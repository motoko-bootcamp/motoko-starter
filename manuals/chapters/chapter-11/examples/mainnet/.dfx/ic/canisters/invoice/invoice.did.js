export const idlFactory = ({ IDL }) => {
  const InvoiceId = IDL.Nat;
  const InvoiceStatus = IDL.Variant({ 'Paid' : IDL.Null, 'Unpaid' : IDL.Null });
  const Result = IDL.Variant({ 'ok' : IDL.Null, 'err' : IDL.Text });
  return IDL.Service({
    'checkStatus' : IDL.Func([InvoiceId], [IDL.Opt(InvoiceStatus)], []),
    'createInvoice' : IDL.Func([], [InvoiceId], []),
    'payInvoice' : IDL.Func([InvoiceId], [Result], []),
  });
};
export const init = ({ IDL }) => { return []; };
