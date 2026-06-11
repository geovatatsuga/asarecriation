package playerUI
{
   import ControlClass.MJCheckBox;
   import ControlClass.MJList;
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
   
   [Embed(source="/_assets/assets.swf", symbol="symbol2951")]
   public dynamic class TaskBoxUIMC extends MovieClip
   {
      
      public var taskAwardContent:MovieClip;
      
      public var tableHadTask:TableButton;
      
      public var taskList:MJList;
      
      public var tableCanReceiveTask:TableButton;
      
      public var scrollTaskCondition:UIScrollBar;
      
      public var scrollTaskAward:UIScrollBar;
      
      public var txtTaskDetail:TextField;
      
      public var txtDeyTaskDescription:TextField;
      
      public var titleBox:MovieClip;
      
      public var scrollTaskDetail:UIScrollBar;
      
      public var cmdClose:SimpleButton;
      
      public var bgBox:MovieClip;
      
      public var txtDeyTaskCondition:TextField;
      
      public var txtDeyTaskAward:TextField;
      
      public var txtTaskCondition:TextField;
      
      public var txtDeyTitle:TextField;
      
      public var chkTaskTracer:MJCheckBox;
      
      public var cmdAbortTask:MainButton;
      
      public function TaskBoxUIMC()
      {
         super();
         __setProp_scrollTaskDetail_TaskBox_content_0();
         __setProp_scrollTaskCondition_TaskBox_content_0();
         __setProp_cmdAbortTask_TaskBox_taskList_0();
         __setProp_chkTaskTracer_TaskBox_taskList_0();
      }
      
      internal function __setProp_chkTaskTracer_TaskBox_taskList_0() : *
      {
         try
         {
            chkTaskTracer["componentInspectorSetting"] = true;
         }
         catch(e:Error)
         {
         }
         chkTaskTracer.enabled = true;
         chkTaskTracer.label = "obf_______2825";
         chkTaskTracer.labelPlacement = "left";
         chkTaskTracer.selected = true;
         chkTaskTracer.visible = true;
         try
         {
            chkTaskTracer["componentInspectorSetting"] = false;
         }
         catch(e:Error)
         {
         }
      }
      
      internal function __setProp_scrollTaskCondition_TaskBox_content_0() : *
      {
         try
         {
            scrollTaskCondition["componentInspectorSetting"] = true;
         }
         catch(e:Error)
         {
         }
         scrollTaskCondition.direction = "vertical";
         scrollTaskCondition.scrollTargetName = "txtTaskCondition";
         scrollTaskCondition.visible = true;
         try
         {
            scrollTaskCondition["componentInspectorSetting"] = false;
         }
         catch(e:Error)
         {
         }
      }
      
      internal function __setProp_scrollTaskDetail_TaskBox_content_0() : *
      {
         try
         {
            scrollTaskDetail["componentInspectorSetting"] = true;
         }
         catch(e:Error)
         {
         }
         scrollTaskDetail.direction = "vertical";
         scrollTaskDetail.scrollTargetName = "txtTaskDetail";
         scrollTaskDetail.visible = true;
         try
         {
            scrollTaskDetail["componentInspectorSetting"] = false;
         }
         catch(e:Error)
         {
         }
      }
      
      internal function __setProp_cmdAbortTask_TaskBox_taskList_0() : *
      {
         try
         {
            cmdAbortTask["componentInspectorSetting"] = true;
         }
         catch(e:Error)
         {
         }
         cmdAbortTask.emphasized = false;
         cmdAbortTask.enabled = true;
         cmdAbortTask.label = "obf_______2994";
         cmdAbortTask.labelPlacement = "right";
         cmdAbortTask.selected = false;
         cmdAbortTask.toggle = false;
         cmdAbortTask.visible = true;
         try
         {
            cmdAbortTask["componentInspectorSetting"] = false;
         }
         catch(e:Error)
         {
         }
      }
   }
}

