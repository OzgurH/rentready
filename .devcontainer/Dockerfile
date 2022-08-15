# Update VARIANT in devcontainer.json to pick a Dart version
ARG VARIANT=2
FROM dart:${VARIANT}

# [Option] Install zsh
ARG INSTALL_ZSH="true"
# [Option] Upgrade OS packages to their latest versions
ARG UPGRADE_PACKAGES="false"

# Install needed packages and setup non-root user. Use a separate RUN statement to add your own dependencies.
ARG USERNAME=vscode
ARG USER_UID=1000
ARG USER_GID=$USER_UID
COPY library-scripts/*.sh /tmp/library-scripts/
RUN apt-get update && /bin/bash /tmp/library-scripts/common-debian.sh "${INSTALL_ZSH}" "${USERNAME}" "${USER_UID}" "${USER_GID}" "${UPGRADE_PACKAGES}" "true" "true" \
    && apt-get clean -y && rm -rf /var/lib/apt/lists/* /tmp/library-scripts

# Add bin location to path
ENV PUB_CACHE="/usr/local/share/pub-cache"
ENV PATH="${PUB_CACHE}/bin:${PATH}"
RUN if ! cat /etc/group | grep -e "^pub-cache:" > /dev/null 2>&1; then groupadd -r pub-cache; fi \
    && usermod -a -G pub-cache ${USERNAME} \
    && umask 0002 \
    && mkdir -p ${PUB_CACHE} \
    && chown :pub-cache ${PUB_CACHE} \
    && sed -i -e "s/export PATH=/export PATH=\/usr\/local\/share\/pub-cache:/" /etc/profile.d/00-restore-env.sh \
    #
    # Fix incorrect privs if present on directories - https://github.com/dart-lang/dart-docker/issues/62, https://github.com/dart-lang/sdk/issues/47093
    && chmod 755 "$DART_SDK" "$DART_SDK/bin"
RUN export CHROME_EXECUTABLE=/usr/bin/chromium
RUN export PATH="$PATH:/home/vscode/development/flutter/bin/flutter/bin"
# [Optional] Uncomment this section to install additional OS packages.
# RUN apt-get update && export DEBIAN_FRONTEND=noninteractive \
#     && apt-get -y install --no-install-recommends <your-package-list-here>

RUN apt-get update \
     && apt-get install -y wget gnupg ca-certificates \
     && wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | apt-key add - \
     && sh -c 'echo "deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google.list' \
     && apt-get update \
     # We install Chrome to get all the OS level dependencies, but Chrome itself
     # is not actually used as it's packaged in the node puppeteer library.
     # Alternatively, we could could include the entire dep list ourselves
     # (https://github.com/puppeteer/puppeteer/blob/master/docs/troubleshooting.md#chrome-headless-doesnt-launch-on-unix)
     # but that seems too easy to get out of date.
     && apt-get install -y google-chrome-stable \
     && rm -rf /var/lib/apt/lists/* \
     && wget --quiet https://raw.githubusercontent.com/vishnubob/wait-for-it/master/wait-for-it.sh -O /usr/sbin/wait-for-it.sh \
     && chmod +x /usr/sbin/wait-for-it.sh
