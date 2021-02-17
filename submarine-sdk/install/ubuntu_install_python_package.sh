set -e
set -u
set -o pipefail

git clone https://github.com/apache/submarine.git
pip install comet_ml
pip install -U comet_ml[cpu_logging]
pip install submarine/submarine-sdk/pysubmarine
pip install numpy==1.19.5 cython pyqlib==0.6.1
