export const idlFactory = ({ IDL }) => {
  const anon_class_8_1 = IDL.Service({
    'getCounts' : IDL.Func([], [IDL.Text], ['query']),
    'increment' : IDL.Func([], [IDL.Nat], []),
    'myCount' : IDL.Func([], [IDL.Nat], ['query']),
  });
  return anon_class_8_1;
};
export const init = ({ IDL }) => { return []; };
