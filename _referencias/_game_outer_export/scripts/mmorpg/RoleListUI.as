package mmorpg
{
   import flash.display.MovieClip;
   import flash.display.SimpleButton;
   import flash.text.TextField;
   
   [Embed(source="/_assets/assets.swf", symbol="symbol242")]
   public dynamic class RoleListUI extends MovieClip
   {
      
      public var txtDeyEnterWorld:TextField;
      
      public var txtDeySetRolePassword:TextField;
      
      public var pointRoleBox1:MovieClip;
      
      public var pointRoleBox2:MovieClip;
      
      public var cmdSetRolePassword:SimpleButton;
      
      public var cmdDeleteRole:SimpleButton;
      
      public var cmdMusic:MovieClip;
      
      public var txtDeyDeleteRole:TextField;
      
      public var cmdCreateRole:SimpleButton;
      
      public var pointRoleBox0:MovieClip;
      
      public var txtDeyCreateRole:TextField;
      
      public var cmdEnterWorld:SimpleButton;
      
      public function RoleListUI()
      {
         super();
      }
   }
}

