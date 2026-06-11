package playerUI
{
   import adobe.utils.*;
   import fl.controls.UIScrollBar;
   import flash.accessibility.*;
   import flash.display.*;
   import flash.errors.*;
   import flash.events.*;
   import flash.external.*;
   import flash.filters.*;
   import flash.geom.*;
   import flash.media.*;
   import flash.net.*;
   import flash.printing.*;
   import flash.profiler.*;
   import flash.sampler.*;
   import flash.system.*;
   import flash.text.*;
   import flash.ui.*;
   import flash.utils.*;
   import flash.xml.*;
   
   [Embed(source="/_assets/assets.swf", symbol="symbol861")]
   public dynamic class FeedBossUIMC extends MovieClip
   {
      
      public var txtdayFeedTimes:TextField;
      
      public var jian0:MovieClip;
      
      public var jian1:MovieClip;
      
      public var jian2:MovieClip;
      
      public var cmdFeed:MainButton;
      
      public var txtExp:TextField;
      
      public var rewardScrollBar:UIScrollBar;
      
      public var txtLv:TextField;
      
      public var pointMC:MovieClip;
      
      public var pictureScrollBar:UIScrollBar;
      
      public var txtDeyTitle:TextField;
      
      public var expBar:MovieClip;
      
      public var cmdCallBoss:MainButton;
      
      public var txtDeyFeed:TextField;
      
      public var titleBox:MovieClip;
      
      public var bg:MovieClip;
      
      public var txtDeyPicture:TextField;
      
      public var icon0:MovieClip;
      
      public var icon1:MovieClip;
      
      public var icon2:MovieClip;
      
      public var iconBar:IconBarMC;
      
      public var cmdClose:SimpleButton;
      
      public var txtBossExp:TextField;
      
      public var icon3:MovieClip;
      
      public var txtDeyHortation:TextField;
      
      public var txtHortation:TextField;
      
      public function FeedBossUIMC()
      {
         super();
         obf_M_P_3914();
         obf_k_Y_4103();
         obf_E_L_3577();
         obf_0_4_7_489();
      }
      
      internal function obf_M_P_3914() : *
      {
         try
         {
            cmdCallBoss["componentInspectorSetting"] = true;
         }
         catch(e:Error)
         {
         }
         cmdCallBoss.emphasized = false;
         cmdCallBoss.enabled = true;
         cmdCallBoss.label = "obf___4895";
         cmdCallBoss.labelPlacement = "right";
         cmdCallBoss.selected = false;
         cmdCallBoss.toggle = false;
         cmdCallBoss.visible = true;
         try
         {
            cmdCallBoss["componentInspectorSetting"] = false;
         }
         catch(e:Error)
         {
         }
      }
      
      internal function obf_E_L_3577() : *
      {
         try
         {
            pictureScrollBar["componentInspectorSetting"] = true;
         }
         catch(e:Error)
         {
         }
         pictureScrollBar.direction = "vertical";
         pictureScrollBar.scrollTargetName = "txtDeyPicture";
         pictureScrollBar.visible = true;
         try
         {
            pictureScrollBar["componentInspectorSetting"] = false;
         }
         catch(e:Error)
         {
         }
      }
      
      internal function obf_0_4_7_489() : *
      {
         try
         {
            rewardScrollBar["componentInspectorSetting"] = true;
         }
         catch(e:Error)
         {
         }
         rewardScrollBar.direction = "vertical";
         rewardScrollBar.scrollTargetName = "txtHortation";
         rewardScrollBar.visible = true;
         try
         {
            rewardScrollBar["componentInspectorSetting"] = false;
         }
         catch(e:Error)
         {
         }
      }
      
      internal function obf_k_Y_4103() : *
      {
         try
         {
            cmdFeed["componentInspectorSetting"] = true;
         }
         catch(e:Error)
         {
         }
         cmdFeed.emphasized = false;
         cmdFeed.enabled = true;
         cmdFeed.label = "obf___4954";
         cmdFeed.labelPlacement = "right";
         cmdFeed.selected = false;
         cmdFeed.toggle = false;
         cmdFeed.visible = true;
         try
         {
            cmdFeed["componentInspectorSetting"] = false;
         }
         catch(e:Error)
         {
         }
      }
   }
}

