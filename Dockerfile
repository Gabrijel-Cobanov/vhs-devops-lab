# Use base image of ubi8/ubi:8.7 and set arbitrary maintainer
FROM ubi8/ubi:8.7
LABEL maintainer="Gabrijel Čobanov <gabrijel.cobanov@gmail.com>"
LABEL version="1.0"


# Define environment variables
ENV NEXUS_VERSION="3.37.3-02"
ENV NEXUS_HOME="/opt/nexus"
ENV SONATYPE_WORK="/opt/nexus/sonatype-work"

# Install the java-1.8.0-openjdk-devel package
RUN yum install -y java-1.8.0-openjdk-devel \
    && yum clean all


# RUN useradd -r -u 200 -m -c "nexus role account" -d ${NEXUS_HOME} -s /bin/false nexus
# Copy and UNPACK donwloaded Nexus bundle into NEXUS_HOME folder
RUN mkdir -p ${NEXUS_HOME}

COPY nexus-3.37.3-02-unix.tar.gz ${NEXUS_HOME}/

RUN tar -xf ${NEXUS_HOME}/nexus-${NEXUS_VERSION}-unix.tar.gz -C ${NEXUS_HOME} \
    && rm ${NEXUS_HOME}/nexus-${NEXUS_VERSION}-unix.tar.gz \
    && cd ${NEXUS_HOME}/nexus-${NEXUS_VERSION} \
    && mv * .. \
    && mv .install4j* .. \
    && cd .. \
    && rmdir ${NEXUS_HOME}/nexus-${NEXUS_VERSION}

# RUN chown -R nexus:nexus ${NEXUS_HOME} ${SONATYPE_WORK}

# Create and switch to user nexus
# USER nexus

# Define default working directory to NEXUS_HOME
WORKDIR ${NEXUS_HOME}
# Define exposed ports
EXPOSE 8081
# Define a volume mount point for the /opt/nexus/sonatype-work container directory
VOLUME ${SONATYPE_WORK}

# Define the command for starting the Nexus server
CMD ["/opt/nexus/bin/nexus", "run"]

