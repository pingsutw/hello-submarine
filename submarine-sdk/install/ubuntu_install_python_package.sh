set -e
set -u
set -o pipefail

git clone https://github.com/apache/submarine.git
pip3 install comet_ml
pip3 install -U comet_ml[cpu_logging]
pip3 install submarine/submarine-sdk/pysubmarine
pip3 install numpy==1.19.5 cython pyqlib==0.6.1
