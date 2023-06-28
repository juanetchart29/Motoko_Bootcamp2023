export const idlFactory = ({ IDL }) => {
  const StudentProfile = IDL.Record({
    'graduate' : IDL.Bool,
    'name' : IDL.Text,
    'team' : IDL.Text,
  });
  const Result = IDL.Variant({ 'ok' : IDL.Null, 'err' : IDL.Text });
  const Content = IDL.Variant({
    'Text' : IDL.Text,
    'Image' : IDL.Vec(IDL.Nat8),
    'Video' : IDL.Vec(IDL.Nat8),
  });
  const Message = IDL.Record({
    'creator' : IDL.Principal,
    'content' : Content,
    'vote' : IDL.Int,
  });
  const Result_2 = IDL.Variant({ 'ok' : Message, 'err' : IDL.Text });
  const Result_1 = IDL.Variant({ 'ok' : StudentProfile, 'err' : IDL.Text });
  const StudentWall = IDL.Service({
    'addMyProfile' : IDL.Func([StudentProfile], [Result], []),
    'deleteMessage' : IDL.Func([IDL.Nat], [Result], []),
    'deleteMyProfile' : IDL.Func([], [Result], []),
    'downVote' : IDL.Func([IDL.Nat], [Result], []),
    'getAllMessages' : IDL.Func([], [IDL.Vec(Message)], ['query']),
    'getAllMessagesRanked' : IDL.Func([], [IDL.Vec(Message)], ['query']),
    'getMessage' : IDL.Func([IDL.Nat], [Result_2], ['query']),
    'seeAProfile' : IDL.Func([IDL.Principal], [Result_1], ['query']),
    'upVote' : IDL.Func([IDL.Nat], [Result], []),
    'updateMessage' : IDL.Func([IDL.Nat, Content], [Result], []),
    'updateMyProfile' : IDL.Func([StudentProfile], [Result], []),
    'verifyWork' : IDL.Func([IDL.Principal, IDL.Principal], [Result], []),
    'writeMessage' : IDL.Func([Content], [IDL.Nat], []),
  });
  return StudentWall;
};
export const init = ({ IDL }) => { return []; };
