import Principal "mo:base/Principal";
import HashMap "mo:base/HashMap";
import Nat "mo:base/Nat";
import Hash "mo:base/Hash";
import Text "mo:base/Text";
import Result "mo:base/Result";
import Buffer "mo:base/Buffer";
import Array "mo:base/Array";
import Int "mo:base/Int";

actor class StudentWall() {

  public type Content = {
    #Text : Text;
    #Image : Blob;
    #Video : Blob;
  };

  type Message = {
    vote : Int;
    content : Content;
    creator : Principal;
  };

  type StudentProfile = {
    name : Text;
    team : Text;
    graduate : Bool;

  };
   func customHash(n : Nat) : Hash.Hash {
        return Text.hash(Nat.toText(n));
    };

  var messageId : Nat = 0;
  let wall = HashMap.HashMap<Nat, Message>(1, Nat.equal, customHash);
  let studentProfileStore = HashMap.HashMap<Principal, StudentProfile>(1, Principal.equal, Principal.hash);

    public shared ({ caller }) func writeMessage(_c : Content) : async Nat {
        let newMsg = {
            vote = 0;
            content = _c;
            creator = caller;
        };

        wall.put(messageId, newMsg);
        messageId += 1;
        return messageId - 1;
    };

    public query func getMessage(_messageId : Nat) : async Result.Result<Message, Text> {
        // let msg = wall.get(_messageId);
        // return #ok(msg);
        switch (wall.get(_messageId)) {
            case (null) return #err("Message doesn't exist.");
            case (?res) return #ok(res);
        };
    };

    public shared ({ caller }) func updateMessage(_messageId : Nat, _c : Content) : async Result.Result<(), Text> {
        switch (wall.get(_messageId)) {
            case (null) return #err("Message not found.");
            case (?res) {
                if (Principal.notEqual(caller, res.creator)) return #err("You don't are the owner.");
                let updated = {
                    vote = res.vote;
                    content = _c;
                    creator = res.creator;
                };
                wall.put(_messageId, updated);
                return #ok();
            };
        };
    };

    public shared ({ caller }) func deleteMessage(_messageId : Nat) : async Result.Result<(), Text> {
        switch (wall.get(_messageId)) {
            case (null) return #err("Message not found.");
            case (?res) {
                if (Principal.notEqual(caller, res.creator)) return #err("You don't are the owner.");

                wall.delete(_messageId);
                return #ok();
            };
        };
    };

    public func upVote(_messageId : Nat) : async Result.Result<(), Text> {
        switch (wall.get(_messageId)) {
            case (null) return #err("Message not found.");
            case (?res) {
                let updated = {
                    vote = res.vote + 1;
                    content = res.content;
                    creator = res.creator;
                };
                wall.put(_messageId, updated);
                return #ok();
            };
        };
    };

    public func downVote(_messageId : Nat) : async Result.Result<(), Text> {
        let msg = switch (wall.get(_messageId)) {
            case (null) return #err("Message not found.");
            case (?res) {
                let updated = {
                    vote = res.vote - 1;
                    content = res.content;
                    creator = res.creator;
                };
                wall.put(_messageId, updated);
                return #ok();
            };
        };
    };

    public query func getAllMessages() : async [Message] {
        let buffMsg = Buffer.Buffer<Message>(1);
        for (msg in wall.vals()) {
            buffMsg.add(msg);
        };

        return Buffer.toArray(buffMsg);
    };

    public query func getAllMessagesRanked() : async [Message] {
        let buffMsg = Buffer.Buffer<Message>(1);
        for (msg in wall.vals()) {
            buffMsg.add(msg);
        };
        let arrMsg = Buffer.toArray<Message>(buffMsg);

        let order = Array.sort<Message>(arrMsg, func(a : Message, b : Message) { return Int.compare(b.vote, a.vote) });
        return order;
    };

    public shared ({ caller }) func addMyProfile(_profile : StudentProfile) : async Result.Result<(), Text> {
        studentProfileStore.put(caller, _profile);
        return #ok();
    };

    public query func seeAProfile(_p : Principal) : async Result.Result<StudentProfile, Text> {
        switch (studentProfileStore.get(_p)) {
            case (null) return #err("User doesn't exist.");
            case (?res) return #ok(res);
        };
    };

    public shared ({ caller }) func updateMyProfile(_profile : StudentProfile) : async Result.Result<(), Text> {
        switch (studentProfileStore.get(caller)) {
            case (null) return #err("User doesn't exist.");
            case (?res) {
                studentProfileStore.put(caller, _profile);
                return #ok();
            };
        };
    };

    public shared ({ caller }) func deleteMyProfile() : async Result.Result<(), Text> {
        switch (studentProfileStore.get(caller)) {
            case (null) return #err("User does't exist.");
            case (?res) {
                studentProfileStore.delete(caller);
                return #ok();
            };
        };
    };

    // day 5
    // TODO preupgrade y postupgrade

    public func verifyWork(_canId : Principal, _pId : Principal) : async Result.Result<(), Text> {

        return #ok();
    };
};