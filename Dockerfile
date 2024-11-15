FROM waltplatform/pc-x86-32-debian:bookworm

RUN apt update -y && apt-get install -y nasm

CMD ["bash"]

