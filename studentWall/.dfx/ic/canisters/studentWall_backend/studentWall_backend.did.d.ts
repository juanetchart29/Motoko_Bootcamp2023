import type { Principal } from '@dfinity/principal';
import type { ActorMethod } from '@dfinity/agent';

export type Content = { 'Text' : string } |
  { 'Image' : Uint8Array | number[] } |
  { 'Video' : Uint8Array | number[] };
export interface Message {
  'creator' : Principal,
  'content' : Content,
  'vote' : bigint,
}
export type Result = { 'ok' : null } |
  { 'err' : string };
export type Result_1 = { 'ok' : StudentProfile } |
  { 'err' : string };
export type Result_2 = { 'ok' : Message } |
  { 'err' : string };
export interface StudentProfile {
  'graduate' : boolean,
  'name' : string,
  'team' : string,
}
export interface StudentWall {
  'addMyProfile' : ActorMethod<[StudentProfile], Result>,
  'deleteMessage' : ActorMethod<[bigint], Result>,
  'deleteMyProfile' : ActorMethod<[], Result>,
  'downVote' : ActorMethod<[bigint], Result>,
  'getAllMessages' : ActorMethod<[], Array<Message>>,
  'getAllMessagesRanked' : ActorMethod<[], Array<Message>>,
  'getMessage' : ActorMethod<[bigint], Result_2>,
  'seeAProfile' : ActorMethod<[Principal], Result_1>,
  'upVote' : ActorMethod<[bigint], Result>,
  'updateMessage' : ActorMethod<[bigint, Content], Result>,
  'updateMyProfile' : ActorMethod<[StudentProfile], Result>,
  'verifyWork' : ActorMethod<[Principal, Principal], Result>,
  'writeMessage' : ActorMethod<[Content], bigint>,
}
export interface _SERVICE extends StudentWall {}
