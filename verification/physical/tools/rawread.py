"""Read an ngspice binary raw file (real transient data). Returns (names, array[npoints, nvars])."""
import numpy as np

def read_raw(path):
    with open(path, "rb") as f:
        names, nv, npnt = [], None, None
        while True:
            line = f.readline()
            if not line:
                raise ValueError("no Binary: section in " + path)
            s = line.decode("ascii", "replace").strip()
            if s.lower().startswith("no. variables:"):
                nv = int(s.split(":")[1])
            elif s.lower().startswith("no. points:"):
                npnt = int(s.split(":")[1])
            elif s.lower().startswith("flags:") and "complex" in s.lower():
                raise ValueError("complex raw file")
            elif s.lower().startswith("variables:"):
                for _ in range(nv):
                    names.append(f.readline().decode().split()[1].lower())
            elif s.lower().startswith("binary:"):
                break
        data = np.fromfile(f, dtype=np.float64, count=nv * npnt)
    n = len(data) // nv
    return names, data[: n * nv].reshape(n, nv)
