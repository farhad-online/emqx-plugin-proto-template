{{=@@ @@=}}
-module(@@name@@_grpc).

-emqx_plugin(?MODULE).

-export([init/1]).
-export([ start/0
        , stop/0
        ]).

-define(SERVICE_CHANNEL_NAME, channel)

start() ->
  ClientOpts = #{},
  ServiceAddr = "",
  {ok, _} = grpc_client_sup:create_channel_pool(
              ?SERVICE_CHANNEL_NAME,
              ServiceAddr,
              ClientOpts
        ).

stop() ->
  grpc_client_sup:stop_channel_pool(?SERVICE_CHANNEL_NAME).

init([]) ->
  SupFlags = #{strategy => one_for_all,
              intensity => 0,
              period => 1},
  ChildSpecs = [],
  {ok, {SupFlags, ChildSpecs}}.
