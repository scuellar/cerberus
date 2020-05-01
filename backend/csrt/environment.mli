open Cerb_frontend
module Loc = Locations

module Global : sig

  type t

  val empty : 
    t

  val add_struct_decl : 
    t -> 
    Sym.t -> 
    Types.t -> 
    t

  val add_fun_decl : 
    t -> 
    Sym.t -> 
    (Loc.t * FunctionTypes.t * Sym.t) -> 
    t

  val add_impl_fun_decl : 
    t -> 
    Implementation.implementation_constant -> 
    FunctionTypes.t -> 
    t

  val add_impl_constant : 
    t -> 
    Implementation.implementation_constant -> 
    BaseTypes.t -> 
    t

  val get_struct_decl : 
    Loc.t ->
    t -> 
    Sym.t -> 
    (Types.t, Loc.t * TypeErrors.type_error) Except.m

  val get_fun_decl : 
    Loc.t ->
    t -> 
    Sym.t -> 
    ((Loc.t * FunctionTypes.t * Sym.t), Loc.t * TypeErrors.type_error) Except.m

  val get_impl_fun_decl : 
    Loc.t ->
    t -> 
    Implementation.implementation_constant -> 
    (FunctionTypes.t, Loc.t * TypeErrors.type_error) Except.m

  val get_impl_constant : 
    Loc.t ->
    t -> 
    Implementation.implementation_constant -> 
    (BaseTypes.t, Loc.t * TypeErrors.type_error) Except.m

  val get_names : 
    t -> 
    NameMap.t
  
  val record_name : 
    t -> 
    Loc.t -> 
    string -> 
    Sym.t -> 
    t

  val record_name_without_loc : 
    t -> 
    string -> 
    Sym.t -> 
    t

  val pp_items :
    t ->
    (int * PPrint.document) list

  val pp : 
    t -> 
    PPrint.document

end



module Local : sig

  type t

  val empty :
    t

  val pp : 
    t -> 
    PPrint.document

  val add_var : 
    t ->
    VarTypes.t Binders.t ->
    t

  val remove_var :
    t -> 
    Sym.t ->
    t

end



module Env : sig

  type t = { global: Global.t; local: Local.t}

  val with_fresh_local :
    Global.t ->
    t

  val add_var : 
    t ->
    VarTypes.t Binders.t ->
    t

  val remove_var :
    t -> 
    Sym.t ->
    t

  val get_Avar : 
    Loc.t ->
    t ->
    Sym.t ->
    (BaseTypes.t, Loc.t * TypeErrors.type_error) Except.m

  val get_Lvar : 
    Loc.t ->
    t ->
    Sym.t ->
    (LogicalSorts.t, Loc.t * TypeErrors.type_error) Except.m

  val get_Rvar : 
    Loc.t ->
    t ->
    Sym.t ->
    (Resources.t * t, Loc.t * TypeErrors.type_error) Except.m

  val get_Cvar : 
    Loc.t ->
    t ->
    Sym.t ->
    (LogicalConstraints.t, Loc.t * TypeErrors.type_error) Except.m

  val owned_resource :
    Loc.t ->
    t ->
    Sym.t ->
    (Sym.t option, Loc.t * TypeErrors.type_error) Except.m

  val get_owned_resource :
    Loc.t ->
    t ->
    Sym.t ->
    (((Sym.t*Resources.t) * t) option, Loc.t * TypeErrors.type_error) Except.m


  val recursively_owned_resources :
    Loc.t ->
    t ->
    Sym.t ->
    (Sym.t list, Loc.t * TypeErrors.type_error) Except.m

end
