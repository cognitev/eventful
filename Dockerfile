FROM elixir:1.7.4


# install node
RUN curl -sL https://deb.nodesource.com/setup_6.x -o nodesource_setup.sh
RUN bash nodesource_setup.sh
RUN apt-get install nodejs

WORKDIR /app

# Configure required environment
ENV MIX_ENV prod

# Set and expose PORT environmental variable
ENV PORT 4000
EXPOSE $PORT

# Install hex (Elixir package manager)
RUN mix local.hex --force

# Install rebar (Erlang build tool)
RUN mix local.rebar --force

# Copy all dependencies files
COPY mix.* ./

# Install all production dependencies
RUN mix deps.get --only prod

# Compile all dependencies
RUN mix deps.compile

# Compile assets
COPY assets ./assets

RUN sh -c "cd assets && npm install"

RUN sh -c "cd assets && node node_modules/brunch/bin/brunch build && npm run deploy"

# Copy all application files
COPY . .

# Compile the entire project
RUN mix compile

RUN mix phx.digest

# Run Ecto migrations and Phoenix server as an initial command
CMD ["./run.sh"]
