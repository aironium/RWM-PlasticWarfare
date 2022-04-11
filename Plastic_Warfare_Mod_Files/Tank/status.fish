[core]
@memory moveSpd:number
@memory disorient:string
@memory fog: number
@memory onWaterSpeed:number
@memory moveSlowed:number
@memory moveStop:number
@memory spdDebug:bool
@memory spdStat:number

[hiddenAction_owsDefault]
autoTriggerOnEvent: created
setUnitMemory: onWaterSpeed = 0, spdDebug=false

[hiddenAction_modifySpeedRealtimeTracked]
autoTrigger: if self.tags(includes="tracked")
autoTriggerCheckRate:every8Frames
setUnitStats: moveSpeed = (memory.moveSpd - ((memory.moveSlowed) + (memory.carryWeight) + (memory.onWaterSpeed)))*(1-(1*memory.moveStop))
setUnitMemory: spdStat = (memory.moveSpd - (1*memory.moveSlowed) - (1*memory.onWaterSpeed) - (1*memory.carryWeight))*(1-(1*memory.moveStop))
alsoTriggerAction: spdDebug

[hiddenAction_modifySpeedRealtimeLegged]
autoTrigger: if self.tags(includes="legged")
autoTriggerCheckRate:every8Frames
setUnitStats: moveSpeed = (memory.moveSpd - ((memory.moveSlowed) + (memory.carryWeight*0.5)))*(1-(1*memory.moveStop))
setUnitMemory: spdStat = (memory.moveSpd - (1*memory.moveSlowed) - (0.5*memory.carryWeight))*(1-(1*memory.moveStop))
alsoTriggerAction: spdDebug

[hiddenAction_spdDebug]
requireConditional: if memory.spdDebug == true
debugMessage: Move speed is at %{memory.spdStat}

[hiddenAction_swSpdDebugOn]
description: %{substring(str(int(self.timeAlive())/30), length(str(int(self.timeAlive())/30))-1, length(str(int(self.timeAlive())/30)))}
text: Speed Debug On
buildSpeed: 0s
price: 0
setUnitMemory: spdDebug = true
#isVisible: if memory.spdDebug == false
pos: -1

[hiddenAction_swSpdDebugOff]
text: Speed Debug Off
buildSpeed: 0s
price: 0
setUnitMemory: spdDebug = false
#isVisible: if memory.spdDebug == true
pos: -1

[hiddenAction_isOnWater]
autoTrigger: if self.isInWater and memory.onWaterSpeed != 1
setUnitMemory: onWaterSpeed = 1
setUnitStats: moveSpeed = (memory.moveSpd - memory.onWaterSpeed)
debugMessage: on water %{(memory.moveSpd - memory.onWaterSpeed)}

[hiddenAction_isOnLand]
autoTrigger: if not self.isInWater and memory.onWaterSpeed == 1
setUnitMemory: onWaterSpeed = 0
setUnitStats: moveSpeed = (memory.moveSpd - memory.onWaterSpeed)
debugMessage: off water

[hiddenAction_statusStunOrStuck]
autoTrigger: if (self.resource.statusStun > 0) or (self.resource.statusStuck > 0)
setUnitMemory: moveStop = 1

[hiddenAction_purgeStun]
autoTrigger: if self.resource.statusStun > 0
addResources: statusStun = -0.5

[hiddenAction_purgeStuck]
autoTrigger: if self.resource.statusStuck > 0
addResources: statusStuck = -0.5

[hiddenAction_notStunAndStuckAndSlowed]
autoTrigger: if (self.resource.statusStun == 0) and (self.resource.statusStuck == 0) and (self.resource.statusSlowed == 0)
setUnitMemory: moveSlowed = 0, moveStop = 0

[hiddenAction_statusSlowed]
autoTrigger: if (self.resource.statusSlowed > 0)
setUnitMemory: moveSlowed = 1

[hiddenAction_purgeSlowed]
autoTrigger: if self.resource.statusSlowed > 0
addResources: statusSlowed = -0.5


[hiddenAction_glitch]
autoTrigger: if self.resource.statusDisorient > 0
text: glitch
buildSpeed: 0s
price: 0
addResources: statusDisorient = -0.5, statusSlowed = 0.5
showMessageToPlayer: %{memory.disorient}
showQuickWarLogToPlayer: %{memory.disorient}
setUnitStats: fogOfWarSightRange=-20
setUnitMemory: fog = -20

[hiddenAction_purgeGlitch]
autoTrigger: if self.resource.statusDisorient < 1
setUnitMemory: fog=20
setUnitStats: fogOfWarSightRange=20