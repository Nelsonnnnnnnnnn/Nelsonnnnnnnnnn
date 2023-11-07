#define LEVEL_REQUIRED 3

public OnPlayerSpawn(playerid) {
    SetTimerEx("CheckPlayerWeapon", 1000, true, "i", playerid);
    return 1;
}

public CheckPlayerWeapon(playerid) {
    if (GetPlayerLevel(playerid) < LEVEL_REQUIRED) {
        new weaponid = GetPlayerWeapon(playerid);
        if (weaponid != 0 && !WeaponRequiresAmmo(weaponid)) {
            // Jika pemain belum mencapai level 3 dan memegang senjata yang tidak memerlukan peluru, sampaikan pesan dan tendang dari server
            SendClientMessage(playerid, COLOR_RED, "Weapon abuse detected! Kamu tidak diizinkan menggunakan senjata ini sebelum mencapai level 3.");
            Kick(playerid);
        }
    }
    return 1;
}

public OnPlayerLevelUp(playerid) {
    if (GetPlayerLevel(playerid) >= LEVEL_REQUIRED) {
        // Hentikan pengecekan jika pemain mencapai level yang diinginkan
        KillTimerEx("CheckPlayerWeapon", "i", playerid);
    }
    return 1;
}

public WeaponRequiresAmmo(weaponid) {
    // Fungsi untuk memeriksa apakah senjata memerlukan peluru atau tidak
    // Sesuaikan dengan jenis senjata di server Anda
    switch (weaponid) {
        case WEAPON_BRASSKNUCKLE, WEAPON_GOLFCLUB, WEAPON_NITESTICK, WEAPON_KNIFE, WEAPON_BAT, WEAPON_SHOVEL, WEAPON_POOLSTICK, WEAPON_KATANA:
            return false;
        default:
            return true;
    }
}
