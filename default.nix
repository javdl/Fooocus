# `export NIXPKGS_ALLOW_UNFREE=1`
# Run with `nix-shell`
{ pkgs ? import <nixpkgs> {} }:
pkgs.mkShell {
   name = "cuda-env-shell";
   buildInputs = with pkgs; [
     git gitRepo gnupg autoconf curl
     python310
     python310Packages.pip
     poetry
   #   python310Packages.torch
   #   python310Packages.torchvision
     python310Packages.torchsde
   #   python310Packages.einops # includes jupyter server
     python310Packages.transformers
     python310Packages.safetensors
     python310Packages.accelerate
     python310Packages.pyyaml
     python310Packages.pillow
     python310Packages.scipy
     python310Packages.tqdm
     python310Packages.psutil
     python310Packages.numpy
     python310Packages.pytorch-lightning
     python310Packages.omegaconf
   #   python310Packages.gradio
     python310Packages.pygit2
   #   python310Packages.opencv-contrib-python
     python310Packages.opencv4
     python310Packages.httpx
     procps gnumake util-linux m4 gperf unzip
     cudatoolkit linuxPackages.nvidia_x11
     libGLU libGL
     xorg.libXi xorg.libXmu freeglut
     xorg.libXext xorg.libX11 xorg.libXv xorg.libXrandr zlib 
     ncurses5 stdenv.cc binutils
   ];
   shellHook = ''
      export CUDA_PATH=${pkgs.cudatoolkit}
      # export LD_LIBRARY_PATH=${pkgs.linuxPackages.nvidia_x11}/lib:${pkgs.ncurses5}/lib
      export EXTRA_LDFLAGS="-L/lib -L${pkgs.linuxPackages.nvidia_x11}/lib"
      export EXTRA_CCFLAGS="-I/usr/include"
      # fixes libstdc++ issues and libgl.so issues
      export LD_LIBRARY_PATH=${pkgs.stdenv.cc.cc.lib}/lib/
   '';          
}