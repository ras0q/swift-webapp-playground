FROM swift:5.9.2

RUN \
  --mount=type=cache,target=/var/lib/apt,sharing=locked \
  --mount=type=cache,target=/var/cache/apt,sharing=locked \
  apt-get update \
  && apt-get upgrade -y \
  && apt-get install -y sudo

ARG USERNAME=user
ARG GROUPNAME=user
ARG UID=1000
ARG GID=1000
RUN groupadd -g ${GID} ${GROUPNAME} \
  && useradd -m -s /bin/bash -u $UID -g $GID $USERNAME

USER ${USERNAME}
WORKDIR /home/$USERNAME
