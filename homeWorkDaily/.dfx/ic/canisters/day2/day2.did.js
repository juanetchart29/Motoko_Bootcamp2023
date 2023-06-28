export const idlFactory = ({ IDL }) => {
  const Homework__1 = IDL.Record({
    'title' : IDL.Text,
    'completed' : IDL.Bool,
    'dueDate' : IDL.Int,
    'description' : IDL.Text,
  });
  const Result = IDL.Variant({ 'ok' : IDL.Null, 'err' : IDL.Text });
  const Result_1 = IDL.Variant({ 'ok' : Homework__1, 'err' : IDL.Null });
  const Homework = IDL.Service({
    'addHomework' : IDL.Func([Homework__1], [IDL.Nat], []),
    'deleteHomework' : IDL.Func([IDL.Nat], [Result], []),
    'getAllHomework' : IDL.Func([], [IDL.Vec(Homework__1)], []),
    'getHomework' : IDL.Func([IDL.Nat], [Result_1], []),
    'getPendingHomework' : IDL.Func([], [IDL.Vec(Homework__1)], []),
    'markAsCompleted' : IDL.Func([IDL.Nat], [Result], []),
    'searchHomework' : IDL.Func([IDL.Text], [IDL.Vec(Homework__1)], ['query']),
    'updateHomework' : IDL.Func([IDL.Nat, Homework__1], [Result], []),
    'verifyWork' : IDL.Func([IDL.Principal, IDL.Principal], [Result], []),
  });
  return Homework;
};
export const init = ({ IDL }) => { return []; };
