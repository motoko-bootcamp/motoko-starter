import type { Principal } from '@dfinity/principal';
import type { ActorMethod } from '@dfinity/agent';

export type ResultMint = { 'ok' : string } |
  { 'err' : string };
export interface _SERVICE { 'getPassword' : ActorMethod<[], ResultMint> }
