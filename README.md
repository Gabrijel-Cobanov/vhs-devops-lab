# TRUE NORTH engineering, DevOps lab

This is a short task for the Junior DevOps (Platform) engineer at True North. The task itself can be found [here](TASK.md).

## Description

This is a repo that contains everyhting needed to setup a [Nexus](https://www.sonatype.com/products/sonatype-nexus-repository) server container that runs automatically upon booting up the machine it is running on. 


## Prerequisites

- **Podman** must be installed  
  https://podman.io/docs/installation
- The **Nexus Repository Manager tarball** must be present **in the same directory as the Dockerfile before building**.
  Tarbal for the exact version in this repo can be downloaded [here](https://download.sonatype.com/nexus/3/nexus-3.37.3-02-unix.tar.gz).
- The directory /tn_devops must exist in the root of the host system.
- The build script must be **executable**. Position inside the directory containing the shell script and run: ``` chmod +x build_image.sh```
- (optional) The run script should be **executable**. Position inside the directory containing the shell script and run: ``` chmod +x run_image.sh```


## Files

- `Dockerfile` - builds the Nexus image
- `build_image.sh` - builds the image
- `run_nexus_image.sh` - runs the image directly (for testing, optional to use)
- `nexus.container` - systemd Quadlet definition


## Quadlet location (required)

Place the `nexus.container` file in **one** of the following locations:

### Rootless Podman (recommended)
- **$HOME/.config/containers/systemd/**

### Rootful Podman
- **/etc/containers/systemd/** or
- **/usr/share/containers/systemd/**


## Usage Steps

1. **Download the Nexus tarball**: Place it in the same directory as the `Dockerfile`.

2. **Build the container image**: Run ```. build_image.sh``` in the terminal

3. **Verify the image has been built**: Verify by running ```podman images``` in the terminal

4. **Postion the Quadlet (nexus.container) in the correct location**

5. **Reload systemd**: (rootles) ```systemctl --user daemon-reload``` (root) ```sudo systemctl daemon-reload```

6. (optional) **Start the service**: (rootles) ```systemctl --user start nexus``` (root) ```sudo systemctl start nexus```

## Access

Nexus will be availible at: 

```
http://localhost:18081
```
  



