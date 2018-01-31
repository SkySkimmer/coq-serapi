(************************************************************************)
(*  v      *   The Coq Proof Assistant  /  The Coq Development Team     *)
(* <O___,, *   INRIA - CNRS - LIX - LRI - PPS - Copyright 1999-2016     *)
(*   \VV/  **************************************************************)
(*    //   *      This file is distributed under the terms of the       *)
(*         *       GNU Lesser General Public License Version 2.1        *)
(************************************************************************)

(************************************************************************)
(* Coq serialization API/Plugin                                         *)
(* Copyright 2016-2017 MINES ParisTech                                  *)
(* Written by: Emilio J. Gallego Arias                                  *)
(************************************************************************)
(* Status: Very Experimental                                            *)
(************************************************************************)

type async_flags = {
  enable_async : string option;
  async_full   : bool;
  deep_edits   : bool;
}

type load_path_spec = {
  coq_path  : Names.DirPath.t;
  unix_path : string;
  recursive : bool;
  has_ml    : bool;
  implicit  : bool;
}

type coq_opts = {

  (* callback to handle async feedback *)
  fb_handler   : Feedback.feedback -> unit;

  (* Initial LoadPath XXX: Use the coq_pkg record? *)
  iload_path   : load_path_spec list;

  (* Libs to require prior to STM init *)
  require_libs : (Names.DirPath.t * string * bool option) list;

  (* Async flags *)
  aopts        : async_flags;

  (* name of the top-level module *)
  top_name     : string;

  (* callback to load cma/cmo files *)
  ml_load      : (string -> unit) option;

  (* Enable Coq Debug mode *)
  debug        : bool;
}

val coq_init : coq_opts -> Stateid.t

(* Default load path for Coq's stdlib *)
val coq_loadpath_default : implicit:bool -> coq_path:string -> load_path_spec list

(* Coq.Init.Prelude Location [will be removed in 8.8] *)
val coq_prelude_mod : coq_path:string -> (Names.DirPath.t * string * bool option)
