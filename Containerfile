FROM quay.io/opendatahub/workbench-images:codeserver-ubi9-python-3.11-20250313-f73eab5

USER 0

WORKDIR /opt/app-root/bin

COPY --chown=1001:0 utils utils/

# Create and install the extensions though build-time on a temporary directory. Later this directory will copied on the `/opt/app-root/src/.local/share/code-server/extensions` via run-code-server.sh file when it starts up.
RUN mkdir -p /opt/app-root/extensions-temp && \
    code-server --install-extension /opt/app-root/bin/utils/Continue.continue-1.1.9@linux-x64.vsix --extensions-dir /opt/app-root/extensions-temp

# Copy the custom code-server launcher
COPY --chown=1001:0 run-code-server.sh ./

USER 1001

WORKDIR /opt/app-root/src