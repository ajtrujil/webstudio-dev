FROM node:18-bullseye-slim as base

ENV PNPM_VERSION=8.8
ENV WEBSTUDIO_COMMIT=f0b3d8fd6e966665accf93dec6ccfa5628a960df
ENV DATABASE_URL=CannotBeEmptyDuringBuildButDoesntSeemToBeUsed
ENV AUTH_SECRET=devs

RUN apt-get update && apt-get install -y openssl git

RUN npm install -g pnpm@${PNPM_VERSION}
RUN cd / && git clone https://github.com/webstudio-is/webstudio.git
RUN cd webstudio && git checkout ${WEBSTUDIO_COMMIT}
WORKDIR /webstudio

RUN pnpm install
RUN pnpm build

CMD ["pnpm", "dev"]