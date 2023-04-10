import type { Principal } from '@dfinity/principal';
import type { ActorMethod } from '@dfinity/agent';

export type InvoiceId = bigint;
export type InvoiceStatus = { 'Paid' : null } |
  { 'Unpaid' : null };
export type Result = { 'ok' : null } |
  { 'err' : string };
export interface _SERVICE {
  'checkStatus' : ActorMethod<[InvoiceId], [] | [InvoiceStatus]>,
  'createInvoice' : ActorMethod<[], InvoiceId>,
  'payInvoice' : ActorMethod<[InvoiceId], Result>,
}
