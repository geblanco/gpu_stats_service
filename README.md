# GPU Stats Service
A systemd service to monitor GPU usage and store it in a daily csv.

# Installation
The service works with a systemd timer that runs every _N_ minutes. By default,
_N_ is set to 5, if you want a different throttle, just change it in
`./gpu_stats.timer`. To install it, just issue `make install` in a shell inside
the repository folder. The script relies on `nvidia-smi`, so it must be
available in your path and executable by the user installing the systemd service.

# Outputs
Daily statistics are stored in `$HOME/gpu_stats` on a daily basis, storing one
row every _N_ minutes, following this format:
| Timestamp  | User    | PID    | GPU Number   | GPU Usage   |
| ---------  | :----   | :----  | :----------- | :---------- |
| 1616584347 | m_user  | 456815 | 1            | 90          |

# Roadmap
(see ideas.txt for more)
* ~~Run statistics every _N_ minutes~~
* Calculate user quota usage
* Plot usage by user/month/hour

# License

MIT License

Copyright (c) 2021 Guillermo Blanco

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
