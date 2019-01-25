%%%-------------------------------------------------------------------
%%% @author saeedrz
%%% @copyright (C) 2015, <COMPANY>
%%% @doc
%%%
%%% @end
%%% Created : 09. Sep 2015 7:28 AM
%%%-------------------------------------------------------------------
-module(mod_available_user).
-author("saeedrz").

-behavior(gen_mod).

-export([
  start/2,
  stop/1,
  process/2
]).

-include("ejabberd.hrl").
-include("jlib.hrl").
-include("web/ejabberd_http.hrl").

start(_Host, _Opts) ->
  ok.

stop(_Host) ->
  ok.

process(Path, _Request) ->
  {xmlelement, "html", [{"xmlns", "http://www.w3.org/1999/xhtml"}],
    [{xmlelement, "head", [],
      [{xmlelement, "title", [], []}]},
      {xmlelement, "body", [],
        [{xmlelement, "p", [], [{xmlcdata, is_user_exists(Path)}]}]}]}.

is_user_exists(User) ->
  Result = ejabberd_auth:is_user_exists(User, "localhost"),
  case Result of
    true -> "The username " ++ User ++ " is already taken.";
    false ->"The username " ++ User ++ " is available."
  end.
