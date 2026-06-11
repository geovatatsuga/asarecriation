package com.sunweb.game.rpg.worldZone.event
{
   import com.sunweb.game.rpg.worldZone.command.team.CommandCodeTeam;
   
   public class TeamEventType
   {
      
      public static const PLAYER_GIVE_TEAM_LEADER_ANSWER:String = CommandCodeTeam.PLAYER_GIVE_TEAM_LEADER_ANSWER.toString(16);
      
      public static const PLAYER_INVITE_TEAM_ANSWER:String = CommandCodeTeam.PLAYER_INVITE_TEAM_ANSWER.toString(16);
      
      public static const PLAYER_JOIN_TEAM_ANSWER:String = CommandCodeTeam.PLAYER_JOIN_TEAM_ANSWER.toString(16);
      
      public static const PLAYER_RECEIVE_GIVE_TEAM_LEADER_REQUEST_NOTIFY:String = CommandCodeTeam.PLAYER_RECEIVE_GIVE_TEAM_LEADER_REQUEST_NOTIFY.toString(16);
      
      public static const PLAYER_RECEIVE_INVITE_TEAM_REQUEST_NOTIFY:String = CommandCodeTeam.PLAYER_RECEIVE_INVITE_TEAM_REQUEST_NOTIFY.toString(16);
      
      public static const PLAYER_RECEIVE_JOIN_TEAM_REQUEST_NOTIFY:String = CommandCodeTeam.PLAYER_RECEIVE_JOIN_TEAM_REQUEST_NOTIFY.toString(16);
      
      public static const PLAYER_TEAM_CHECK_NOTIFY:String = CommandCodeTeam.PLAYER_TEAM_CHECK_NOTIFY.toString(16);
      
      public static const PLAYER_TEAM_LEADER_CHANGE_NOTIFY:String = CommandCodeTeam.PLAYER_TEAM_LEADER_CHANGE_NOTIFY.toString(16);
      
      public static const PLAYER_TEAM_MEMBER_CHECK_NOTIFY:String = CommandCodeTeam.PLAYER_TEAM_MEMBER_CHECK_NOTIFY.toString(16);
      
      public static const PLAYER_TEAM_MEMBER_HP_CHANGE_NOTIFY:String = CommandCodeTeam.PLAYER_TEAM_MEMBER_HP_CHANGE_NOTIFY.toString(16);
      
      public static const PLAYER_TEAM_MEMBER_MP_CHANGE_NOTIFY:String = CommandCodeTeam.PLAYER_TEAM_MEMBER_MP_CHANGE_NOTIFY.toString(16);
      
      public static const PLAYER_TEAM_ITEM_MODE_CHECK_NOTIFY:String = CommandCodeTeam.PLAYER_TEAM_ITEM_MODE_CHECK_NOTIFY.toString(16);
      
      public static const PLAYER_TEAM_ROLL_ITEMS_CHECK_NOTIFY:String = CommandCodeTeam.PLAYER_TEAM_ROLL_ITEMS_CHECK_NOTIFY.toString(16);
      
      public static const PLAYER_TEAM_ROLL_ITEM_ADDED_NOTIFY:String = CommandCodeTeam.PLAYER_TEAM_ROLL_ITEM_ADDED_NOTIFY.toString(16);
      
      public static const PLAYER_ROLL_ITEM_ANSWER:String = CommandCodeTeam.PLAYER_ROLL_ITEM_ANSWER.toString(16);
      
      public static const PLAYER_TEAM_ROLL_RESULT_NOTIFY:String = CommandCodeTeam.PLAYER_TEAM_ROLL_RESULT_NOTIFY.toString(16);
      
      public function TeamEventType()
      {
         super();
      }
   }
}

