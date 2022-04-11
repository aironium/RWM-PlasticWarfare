[core]
autoTriggerCooldownTime: 0.5s
name: pack_${name}
displayText: ${label}
displayText_ru: ${label_ru}
#displayDescription
price: 0
buildSpeed: 0
maxHp: 3
class: CustomUnitMetadata
mass: 9000
techLevel: 1
radius: 10
displayRadius: 10
isBug: false
isBio: false
@memory lastTeam:number
tags:item, ${name}, packs
canNotBeGivenOrdersByPlayer: true
experimental: false
disableAllUnitCollisions: true
isUnrepairableUnit:true
isUnselectable: true
canNotBeDirectlyAttacked: true 
stayNeutral: true
createNeutral: true
fogOfWarSightRange: 0

[hiddenAction_rotateToNorth]
autoTrigger: if self.dir() != 90
setBodyRotation: -90

[hiddenAction_assignLastTeam]
autoTrigger: if self.hasParent(withTag="player") and (memory.lastTeam != parent.teamId())
setUnitMemory: lastTeam=parent.teamId()
debugMessage: Item ${label} last team is now %{parent.teamId()} 

[hiddenAction_moreEnemy]
autoTrigger: if numberOfUnitsInEnemyTeam(withTag="rover", withinRange=50) > numberOfUnitsInTeam(withTag="rover", withinRange=50)
switchToTeam: nearestUnit(withTag="rover", relation="enemy", withinRange=50).teamId()

[hiddenAction_thereAreRovers]
autoTrigger: if nearestUnit(withTag="rover", relation="any", withinRange=50) != null
switchToTeam: nearestUnit(withTag="rover", relation="any", withinRange=50).teamId()

[hiddenAction_autoNeutral]
switchToNeutralTeam: true
autoTrigger: if numberOfUnitsInTeam(withTag="player", lessThan=1, withinRange=60)
addResources: unsetFlag=0


[hiddenAction_deleteWhenNoParentAndFromSpawner]
autoTrigger: if not self.hasParent() and self.timeAlive() > 50
deleteSelf: true

[hiddenAction_energyPack]
autoTrigger: if self.hasParent(withTag="rover")
requireConditional: if self.tags(includes="energy")
addResources: charge=500
deleteSelf: true
showQuickWarLogToPlayer: [+500] Energy charge acquired 

[hiddenAction_repairPack]
autoTrigger: if self.hasParent(withTag="rover")
requireConditional: if self.tags(includes="repair")
deleteSelf: true
showQuickWarLogToPlayer: [+1] Repair Pack acquired
takeResources: repairPack=-1
takeResources_includeParent: true
takeResources_discardCollected: true

[hiddenAction_shieldPack]
autoTrigger: if self.hasParent(withTag="rover") and not parent.tags(includes="walker")
requireConditional: if self.tags(includes="shield")
deleteSelf: true
showQuickWarLogToPlayer: [+250] Plasma Shield acquired
takeResources: shield=-250
takeResources_includeParent: true
takeResources_discardCollected: true

[hiddenAction_shieldPackB]
autoTrigger: if self.hasParent(withTag="rover") and parent.tags(includes="walker")
requireConditional: if self.tags(includes="shield")
deleteSelf: true
showQuickWarLogToPlayer: [+250] Plasma Shield converted to Energy Charge
takeResources: charge=-250
takeResources_includeParent: true
takeResources_discardCollected: true

[graphics]
total_frames: 1
image: back.png
image_wreak: NONE
image_turret: NONE
image_back: back.png
disableLowHpSmoke: true
disableLowHpFire: true

[arm_1]
image_end: i_${name}.png
spinRate: 0.75
x: 0
y: 0

[attack]
canAttackLandUnits: true
canAttack: false
canAttackFlyingUnits: false
canAttackUnderwaterUnits: false
dieOnAttack: true
turretSize: 12
turretTurnSpeed: 6
maxAttackRange: 20
shootDelay: 0.1s

[movement]
movementType: HOVER
moveSpeed: 0
moveAccelerationSpeed: 0.5
moveDecelerationSpeed: 0.5
targetHeight: 2
maxTurnSpeed: 0.5
turnAcceleration: 1
targetHeight: 2
