# Use the official JDK image as the base image
FROM maven:3-ibm-semeru-17-focal

# Copy your local github access token file first to leverage Docker cache
COPY settings.xml /usr/share/maven/ref/settings.xml
COPY settings.xml /root/.m2/settings.xml

# Install and setup NeoVim
RUN mkdir -p /root/.config/nvim
COPY ./neovim/init.lua /root/.config/nvim
RUN apt update && apt upgrade -y
RUN apt install -y gcc
RUN apt install -y nodejs npm
RUN curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim.appimage
RUN chmod u+x nvim.appimage
RUN ./nvim.appimage --appimage-extract
RUN ./squashfs-root/AppRun --version
RUN ln -s /squashfs-root/AppRun /usr/bin/nvim
RUN nvim --headless "+Lazy! sync" +qa

WORKDIR /root/repos/

# Expose the port on which Flask will run
EXPOSE 8500