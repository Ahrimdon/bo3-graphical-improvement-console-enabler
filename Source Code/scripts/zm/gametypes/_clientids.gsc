#using scripts\codescripts\struct;

#using scripts\shared\callbacks_shared;
#using scripts\shared\system_shared;

#using scripts\shared\flag_shared;	//Spawn message flags
#using scripts\shared\array_shared;	//Spawn message array

#insert scripts\shared\shared.gsh;

#namespace clientids;

REGISTER_SYSTEM( "clientids", &__init__, undefined )
	
function __init__()
{
	callback::on_start_gametype( &init );
	callback::on_connect( &on_player_connect );
//	callback::on_spawned( &on_player_spawned ); //Call spawn message function (Remove // from beginning of line)
}	

function init()
{
	// this is now handled in code ( not lan )
	// see s_nextScriptClientId 
	level.clientid = 0;
	//Client Dvars
	SetDvar("r_dof_enable", "0");
	SetDvar("r_lodbiasrigid", "-1000");
	SetDvar("r_modellodbias", "10");
}

function on_player_connect()
{
	self.clientid = matchRecordNewPlayer( self );
	if ( !isdefined( self.clientid ) || self.clientid == -1 )
	{
		self.clientid = level.clientid;
		level.clientid++;	// Is this safe? What if a server runs for a long time and many people join/leave
	}

}
/* //Delete this line
function on_player_spawned()
{
	level flag::wait_till("initial_blackscreen_passed"); //Wait until blackscreen has passed
	//Spawn message
	self iPrintLnBold("Follow ^2@thahrimdon ^7on ^1YouTube ^7& ^6Twitch^7!"); //Customize spawn message In ""
}
*/ //Delete this line
