#!/bin/bash
podman run -d --replace --name nexus -p 18081:8081 -v /tn_devops/nexus:/opt/nexus/sonatype-work localhost/nexus:3.37.3
