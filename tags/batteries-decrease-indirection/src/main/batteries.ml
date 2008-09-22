(*
 * Batlib - Root of Batteries Included hierarchy
 * Copyright (C) 2008 David Teller, LIFO, Universite d'Orleans
 * 
 * This library is free software; you can redistribute it and/or
 * modify it under the terms of the GNU Lesser General Public
 * License as published by the Free Software Foundation; either
 * version 2.1 of the License, or (at your option) any later version,
 * with the special exception on linking described in file LICENSE.
 *
 * This library is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
 * Lesser General Public License for more details.
 *
 * You should have received a copy of the GNU Lesser General Public
 * License along with this library; if not, write to the Free Software
 * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
 *)

module Control     = struct
  (** Tools for changing the control flow of a program, from error-management to concurrency.*)
(*
  module Concurrency = struct (** Everything related to parallelism and concurrency. *)
    module Threads = struct (** Concurrency operations as defined by OCaml's base library *)
      module Condition = Condition
      module Event     = Event
      module Mutex     = Mutex
      module Thread    = Thread
    end
  end
*)
  module Labels      = Batlib_Misc_Labels
end

module Data        = struct (** {6 Data structures}*)
  module Containers  = struct
    module Mutable         = struct (** Mutable containers (arrays, stacks...)*)
      module Array         = Extlib.ExtArray.Array         (*formerly Batlib_Baselib_Array*)
      module ArrayLabels   = Batlib_Baselib_ArrayLabels
      module Bigarray      = Batlib_Baselib_Bigarray     (*TODO:make enumerable*)
      module BitSet        = Extlib.BitSet
      module Dynarray      = Extlib.DynArray
      module Enum          = Extlib.Enum
      module Global        = Extlib.Global
      module Hashtbl       = Extlib.ExtHashtbl.Hashtbl       (*formerly Batlib_Baselib_Hashtbl*) 
	(* ?? HashedType in Batlib_Extlib_Hashtbl *)
      module HashtblLabels = Batlib_Baselib_HashtblLabels(*TODO:Bring to feature parity with {!Hashtbl}*)
      module Queue         = Batlib_Baselib_Queue        (*TODO:build from enum?*)
      module RefList       = Extlib.RefList
      module Stack         = Batlib_Baselib_Stack        (*TODO:build from enum*)
      module Stream        = Batlib_Baselib_Stream       (*TODO:replace with latest version*)
    end
    module Persistent      = struct (** Persistent containers *)
      module Dllist          = Extlib.Dllist
      module Immutable_array = Extlib.ExtArray.ROArray
      module Lazy            = Batlib_Baselib_Lazy
      module List            = Extlib.ExtList.List      (*formerly Batlib_Baselib_List*)
      module ListLabels      = Batlib_Baselib_ListLabels(*TODO:Bring to feature parity with {!List}*)
      module Map             = Batlib_Baselib_Map       (*TODO:make enumerable*)
      module MapLabels       = Batlib_Baselib_MapLabels (*TODO:make enumerable*)
      module PMap            = Batlib_Baselib_Map
      module Option          = Extlib.Option
      module Set             = Batlib_Baselib_Set       (*TODO:make enumerable*)
      module SetLabels       = Batlib_Baselib_SetLabels (*TODO:make enumerable*)
    end
  end
    
  module Logical     = struct (** Boolean and bit-oriented data structures *)
    module Bitset = Extlib.BitSet
    module Bool   = Extlib.ExtBool.Bool
  end
    
  module Numeric     = struct (** Numbers, operations and other mathematics.*)
    (*module Interfaces  = Batlib_Interfaces_Numeric*)
    module Big_int     = Extlib.ExtBig_int.Big_int
    module Complex     = Extlib.ExtComplex.Complex
    module Int         = Extlib.ExtInt.Int
    module Int32       = Extlib.ExtInt32.Int32
    module Int64       = Extlib.ExtInt64.Int64
    module Native_int  = Extlib.ExtNativeint.Nativeint
    module Num         = Extlib.ExtNum.Num
    module Safe_int    = Extlib.ExtInt.SafeInt
  end
    
  module Text        = struct (** Text data structures. *)
    
    (** {6 Latin-1}*)
    module Buffer          = Batlib_Baselib_Buffer
    module Char            = Extlib.ExtChar.Char
    module String          = struct
      include Extlib.ExtString.String
      external length : string -> int = "%string_length"
      external get : string -> int -> char = "%string_safe_get"
      external set : string -> int -> char -> unit = "%string_safe_set"
      external create : int -> string = "caml_create_string"
    end
    module StringLabels    = Batlib_Baselib_StringLabels  (*todo: wrap [Batlib_Extlib_String] with labels*)
  end
end

module Languages   = struct
  (**
     Parsing, printing, regular expressions and other transformations from text
     to data, from data to text and from text to text.
  *)

  (** {1 Parsing} *)
  
  module Genlex          = Batlib_Baselib_Genlex
  module Lexing          = Batlib_Baselib_Lexing
  module Parsing         = Batlib_Baselib_Parsing
  module Scanf           = Batlib_Baselib_Scanf
  module Str             = Batlib_Baselib_Str
    
  (** {1 Printing}*)
    
  module Format          = Batlib_Baselib_Format
  module Printexc        = Batlib_Baselib_Printexc
  module Printf          = struct
    include Extlib.IO.Printf
    let make_list_printer    = Extlib.IO.make_list_printer
    let lmargin              = Extlib.IO.lmargin
    type ('a, 'b, 'c) format = ('a, 'b, 'c) Pervasives.format

  end
    
    (**/**)
    
    (**
       {1 Note to developers}
       
       This module is meant to contain specifically tools which may be used for parsing
       and for printing. Regular expressions are presented in this module insofar as
       they may be used for both purposes.
       
       Here is a list of other tasks which may be added here
       - serialization-to-human-readable-formats 
       - xml, dom, etc.
       
       Here is a list of tasks which should probably not be added here
       - unicode utilities which have no special relation to parsing or printing (put them in {!Batlib.Data.Text})
       - bindings to other programming languages (no real place to put them yet, for the moment, {!Batlib.Meta})
    *)
end
module Meta        = struct (** Meta-level operations (marshalling, garbage-collection...) *)
  
  (** {1 Language}*)
  
  module Marshal        = Batlib_Baselib_Marshal
  module Oo             = Batlib_Baselib_Oo
    
  (** {1 Interaction with other languages} *)
    
  module Callback       = Batlib_Baselib_Callback
    
  (** {1 Memory}*)
    
  module Gc             = Batlib_Baselib_Gc
  module Weak           = Batlib_Baselib_Weak
    
  (** {1 Internals}
      Here Be Dragons*)
    
  module Obj            = Batlib_Baselib_Obj
  module CamlinternalMod= Batlib_Baselib_CamlinternalMod
  module CamlinternalOO = Batlib_Baselib_CamlinternalOO
    
end
module Standard    = struct (** Automatically opened module. *) 
  include Batlib_Baselib_Pervasives
  include Extlib.Std
  let (@) = Extlib.ExtList.(@)
(* XXX Why not just include these in the toplevel batteries module? *)
end
module System      = struct 
  (** Interactions with the operating system (file manipulation, arguments...) *)
  
  (** {1 Environment I/O}*)
  
  module Arg           = Batlib_Baselib_Arg
  module OptParse      = Extlib.OptParse
    
  (** {1 Operations on streams}*)
    
  module IO            = Extlib.IO
  module Unzip         = Extlib.Unzip
    
  (** {1 Actual operating system calls}*)
    
  module File          = Extlib.File
  module Filename      = Batlib_Baselib_Filename
  module Unix          = Batlib_Baselib_Unix
  module UnixLabel     = Batlib_Baselib_UnixLabels
  module Sys           = Batlib_Baselib_Sys
    
  (** {1 Networking}*)
  module Network       = struct
    (** Placeholder *)
  end
end
module Toolchain   = struct
  (** Tools for compiling OCaml, generating documentation, installing libraries. *)
  
  (**Accessing information on source files from OCamlDoc*)
  (*module Odoc_info   = Batlib_Ocamldoc_Odoc_info -- removed for now*)
  
  (**Package management with Findlib*)
  module Findlib     = Batlib_Findlib_Findlib
end
module Util        = struct (** Miscellaneous utilities *)
  module Base64 = Extlib.Base64
  module Digest = Batlib_Baselib_Digest
  module Random = Batlib_Baselib_Random
end
