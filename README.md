# Salkin Server Core

## Features
- **Lawn Mowing**: Players can mow lawns to earn points, which can be sold for money.
- **Vending Machine**: Players can interact with vending machines to buy drinks.
- **Weapon Disabling**: Prevents weapon use while mowing.
- **Blip on Map**: Displays a marker for the lawn mowing area.

## Requirements
- ESX Framework
- ox_lib
- ox_target

## Installation
1. Download and place the script in your server’s resources folder.
2. Add to `server.cfg`:
   ```
   start salkin_server_core
   ```
3. Ensure ESX is properly set up on your server.

## Configuration
- **Config.Zones**: Define mowing zones.
- **Config.DrawDistance**: Set the draw distance for markers.
- **Config.Target**: Set up target system for vending machines.

## How to Use
- **Mowing**: Find the marked zone, press **E** to open the menu, select "Start" to mow and earn points.
- **Sell Points**: Once you have points, select "Sell" to exchange them for money.
- **Vending Machine**: Approach and press **E** to buy drinks from vending machines.
- **Weapon Disabling**: Disables weapon usage while mowing.

## Controls
- **E**: Open menu at mower zones and vending machines.
- **WASD**: Movement.

## Notifications
- The script will notify players when:
  - They start mowing.
  - Points are earned.
  - Points are sold.

## License
Released under the MIT license.
