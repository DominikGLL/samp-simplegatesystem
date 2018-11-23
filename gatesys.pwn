#include <a_samp>
#include <streamer>
#include <zcmd>

#define MAX_GATES 			1

enum GateEnum {
	GateName[16],
	GateModel,
	Float:GateClose[6],
	Float:GateOpen[6],
	bool:GateState,
	GateObject,
	Text3D:GateLabel
}
new GateInfo[MAX_GATES][GateEnum] = {
	{"LSPD Tor", 971, {1588.6819, -1638.0350,8.0000, 0.000, 0.000, 0.000}, {1588.6819, -1638.0350, 13.8529, 0.000, 0.000, 0.000}}
};

COMMAND:gate(playerid, params[]){
	for(new i; i < MAX_GATES; i++){
	    if(!IsPlayerInRangeOfPoint(playerid, 7.0, GateInfo[i][GateClose][0], GateInfo[i][GateClose][1], GateInfo[i][GateClose][2]))continue;
		return ((GateInfo[i][GateState]) ?
				(MoveDynamicObject(GateInfo[i][GateObject], GateInfo[i][GateClose][0], GateInfo[i][GateClose][1], GateInfo[i][GateClose][2], GateInfo[i][GateClose][3], GateInfo[i][GateClose][4], GateInfo[i][GateClose][5], 5.0), GateInfo[i][GateState] = false) :
				(MoveDynamicObject(GateInfo[i][GateObject], GateInfo[i][GateOpen][0], GateInfo[i][GateOpen][1], GateInfo[i][GateOpen][2], GateInfo[i][GateOpen][3], GateInfo[i][GateOpen][4], GateInfo[i][GateOpen][5], 5.0), GateInfo[i][GateState] = true));
	}
	return 1;
}


public OnGameModeInit()
{
	SetGameModeText("Gate Tutorial");
	AddPlayerClass(0, 1958.3783, 1343.1572, 15.3746, 269.1425, 0, 0, 0, 0, 0, 0);
	
	for(new i = 0; i < MAX_GATES; i++) {
	    GateInfo[i][GateState] = false;
	    GateInfo[i][GateObject] = CreateDynamicObject(GateInfo[i][GateModel], GateInfo[i][GateClose][0], GateInfo[i][GateClose][1], GateInfo[i][GateClose][2], GateInfo[i][GateClose][3], GateInfo[i][GateClose][4], GateInfo[i][GateClose][5]);
		GateInfo[i][GateLabel] = CreateDynamic3DTextLabel(GateInfo[i][GateName], 0x008080FF, GateInfo[i][GateClose][0], GateInfo[i][GateClose][1], GateInfo[i][GateClose][2], 15.0);
	}
	return 1;
}
