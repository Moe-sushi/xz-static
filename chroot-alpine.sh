apt update
apt install -y sudo
sudo apt install -y git wget
yes|sudo apt install --no-install-recommends -y curl xz-utils jq gzip file \
              make \
              clang \
              libseccomp-dev \
              libcap-dev \
              libc6-dev \
              binutils 
bash -c ". <(curl -sL https://get.ruri.zip/rurima) -s"
./rurima lxc pull -s ./alpine -o alpine -v 3.19
[[ $? == 0 ]]||./rurima lxc pull -s ./alpine -o alpine -v edge
git clone https://github.com/moe-hacker/ruri
cd ruri
cc -Wl,--gc-sections -static src/*.c src/easteregg/*.c -o ruri -lcap -lseccomp -lpthread
cd ..
sudo cp file.c alpine/file.c
sudo cp build.sh alpine/build.sh
sudo chmod +x alpine/build.sh
sudo ./ruri/ruri ./alpine /bin/sh /build.sh
cp alpine/$(uname -m).tar .
if [[ $(uname -m) == "amd64" ]]||[[ $(uname -m) == "x86_64" ]]; then
  bash build-x86.sh
fi
