# Build container:
# > docker build --tag win64_msvc2022:0.1 ./docker

# Run container:
# > docker run -it -v c:/Users/fiske/projects/msbuilddockerimage/:c:/project win64_msvc2022:0.1
# -i interactive
# -t make tty

# escape=`

FROM mcr.microsoft.com/dotnet/framework/runtime:4.8-windowsservercore-ltsc2022

SHELL ["powershell"]

## Install chocolatey
ENV chocolateyUseWindowsCompression false
RUN Set-ExecutionPolicy Bypass -Scope Process -Force; [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))

RUN choco feature enable -n allowGlobalConfirmation
RUN choco feature disable -n showDownloadProgress

# CMake and other tools
RUN choco install cmake --installargs 'ADD_CMAKE_TO_PATH=System'
RUN choco install 7zip curl git ninja

# Update the path to include 7-Zip
#RUN setx /M PATH $($Env:PATH + ';C:\Program Files\7-Zip')
RUN $env:Path += ';C:\Program Files\7-Zip'
#RUN [Environment]::SetEnvironmentVariable("PATH", $env:Path, "SYSTEM")

# Create a folder to use for bind mounting
RUN New-Item -Type Directory -Path C:\project

# Qt
RUN choco install python
RUN python -m pip install --upgrade pip
RUN pip install wheel
RUN pip install aqtinstall

RUN New-Item -Type Directory -Path C:\Qt
RUN aqt install-qt --outputdir C:\Qt windows desktop 5.15.2 win64_msvc2019_64

ENV QTDIR "C:\Qt\5.15.2\msvc2019_64"

## VS 2022
ENV VS_BUILD_TOOLS_INSTALL_PATH=C:/BuildTools
RUN choco install visualstudio2022buildtools --package-parameters \"--installPath $ENV:VS_BUILD_TOOLS_INSTALL_PATH\"
RUN choco install visualstudio2022-workload-vctools --package-parameters "--includeRecommended"

# Entrypoint is a powershell that executes Launch-VsDevShell.ps1 with arguments to setup BuildTools to x64. It then
# executes a subsequent powershell that inherits its predecessors environment and stays interactive.
ENTRYPOINT ["powershell", "/BuildTools/Common7/Tools/Launch-VsDevShell.ps1", "-Arch", "amd64", ";", "powershell"]
