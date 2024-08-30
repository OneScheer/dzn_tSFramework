#include "script_component.hpp"

/*
    (_self)

    Params:
        nothing
    Returns:
        nothing
*/

__CLIENT_ONLY__

params [
    ["_forcedLocation", nil],
    ["_timeout", 0]
];
DEBUG_1("(scheduleRespawn) Params: %1", _this);

if (alive player) exitWith {
    setPlayerRespawnTime RESPAWN_TIME_DISABLED;
};

_timeout = _timeout + SETTING(_self,BeforeRespawnTimeout);

if (!isNil "_forcedLocation") then {
    _self set [Q(ForcedRespawnLocation), _forcedLocation];
    DEBUG_1("(scheduleRespawn) Forced Respawn Location set to: %1", _forcedLocation);
};

player setVariable [QGVAR(Scheduled), true, true];

_self call [F(showMessage), [MODE_BEFORE_RESPAWN_MSG, [_timeout]]];
setPlayerRespawnTime _timeout;
