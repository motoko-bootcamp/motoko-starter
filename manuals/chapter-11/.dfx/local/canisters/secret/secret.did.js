export const idlFactory = ({ IDL }) => {
  const ResultMint = IDL.Variant({ 'ok' : IDL.Text, 'err' : IDL.Text });
  return IDL.Service({ 'getPassword' : IDL.Func([], [ResultMint], []) });
};
export const init = ({ IDL }) => { return []; };
