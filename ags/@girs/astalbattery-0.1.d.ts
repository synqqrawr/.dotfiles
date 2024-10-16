/// <reference path="./gio-2.0.d.ts" />
/// <reference path="./gobject-2.0.d.ts" />
/// <reference path="./glib-2.0.d.ts" />
/// <reference path="./gmodule-2.0.d.ts" />

/**
 * Type Definitions for Gjs (https://gjs.guide/)
 *
 * These type definitions are automatically generated, do not edit them by hand.
 * If you found a bug fix it in `ts-for-gir` or create a bug report on https://github.com/gjsify/ts-for-gir
 *
 * The based EJS template file is used for the generated .d.ts file of each GIR module like Gtk-4.0, GObject-2.0, ...
 */

declare module 'gi://AstalBattery?version=0.1' {
    // Module dependencies
    import type Gio from 'gi://Gio?version=2.0';
    import type GObject from 'gi://GObject?version=2.0';
    import type GLib from 'gi://GLib?version=2.0';
    import type GModule from 'gi://GModule?version=2.0';

    export namespace AstalBattery {
        /**
         * AstalBattery-0.1
         */

        export namespace State {
            export const $gtype: GObject.GType<State>;
        }

        enum State {
            UNKNOWN,
            CHARGING,
            DISCHARGING,
            EMPTY,
            FULLY_CHARGED,
            PENDING_CHARGE,
            PENDING_DISCHARGE,
        }

        export namespace Technology {
            export const $gtype: GObject.GType<Technology>;
        }

        enum Technology {
            UNKNOWN,
            LITHIUM_ION,
            LITHIUM_POLYMER,
            LITHIUM_IRON_PHOSPHATE,
            LEAD_ACID,
            NICKEL_CADMIUM,
            NICKEL_METAL_HYDRIDE,
        }

        export namespace WarningLevel {
            export const $gtype: GObject.GType<WarningLevel>;
        }

        enum WarningLevel {
            UNKNOWN,
            NONE,
            DISCHARGING,
            LOW,
            CRITICIAL,
            ACTION,
        }

        export namespace BatteryLevel {
            export const $gtype: GObject.GType<BatteryLevel>;
        }

        enum BatteryLevel {
            UNKNOWN,
            NONE,
            LOW,
            CRITICIAL,
            NORMAL,
            HIGH,
            FULL,
        }

        export namespace Type {
            export const $gtype: GObject.GType<Type>;
        }

        enum Type {
            UNKNOWN,
            LINE_POWER,
            BATTERY,
            UPS,
            MONITOR,
            MOUSE,
            KEYBOARD,
            PDA,
            PHONE,
            MEDIA_PLAYER,
            TABLET,
            COMPUTER,
            GAMING_INPUT,
            PEN,
            TOUCHPAD,
            MODEM,
            NETWORK,
            HEADSET,
            SPEAKERS,
            HEADPHONES,
            VIDEO,
            OTHER_AUDIO,
            REMOVE_CONTROL,
            PRINTER,
            SCANNER,
            CAMERA,
            WEARABLE,
            TOY,
            BLUETOOTH_GENERIC,
        }
        const MAJOR_VERSION: number;
        const MINOR_VERSION: number;
        const MICRO_VERSION: number;
        const VERSION: string;
        function type_get_icon_name(): string | null;
        function type_get_name(): string | null;
        function get_default(): Device;
        module Device {
            // Constructor properties interface

            interface ConstructorProps extends GObject.Object.ConstructorProps {
                device_type: Type;
                deviceType: Type;
                native_path: string;
                nativePath: string;
                vendor: string;
                model: string;
                serial: string;
                update_time: number;
                updateTime: number;
                power_supply: boolean;
                powerSupply: boolean;
                has_history: boolean;
                hasHistory: boolean;
                has_statistics: boolean;
                hasStatistics: boolean;
                online: boolean;
                energy: number;
                energy_empty: number;
                energyEmpty: number;
                energy_full: number;
                energyFull: number;
                energy_full_design: number;
                energyFullDesign: number;
                energy_rate: number;
                energyRate: number;
                voltage: number;
                charge_cycles: number;
                chargeCycles: number;
                luminosity: number;
                time_to_empty: number;
                timeToEmpty: number;
                time_to_full: number;
                timeToFull: number;
                percentage: number;
                temperature: number;
                is_present: boolean;
                isPresent: boolean;
                state: State;
                is_rechargable: boolean;
                isRechargable: boolean;
                capacity: number;
                technology: Technology;
                warning_level: WarningLevel;
                warningLevel: WarningLevel;
                battery_level: BatteryLevel;
                batteryLevel: BatteryLevel;
                icon_name: string;
                iconName: string;
                charging: boolean;
                is_battery: boolean;
                isBattery: boolean;
                battery_icon_name: string;
                batteryIconName: string;
                device_type_name: string;
                deviceTypeName: string;
                device_type_icon: string;
                deviceTypeIcon: string;
            }
        }

        class Device extends GObject.Object {
            static $gtype: GObject.GType<Device>;

            // Properties

            get device_type(): Type;
            set device_type(val: Type);
            get deviceType(): Type;
            set deviceType(val: Type);
            get native_path(): string;
            set native_path(val: string);
            get nativePath(): string;
            set nativePath(val: string);
            get vendor(): string;
            set vendor(val: string);
            get model(): string;
            set model(val: string);
            get serial(): string;
            set serial(val: string);
            get update_time(): number;
            set update_time(val: number);
            get updateTime(): number;
            set updateTime(val: number);
            get power_supply(): boolean;
            set power_supply(val: boolean);
            get powerSupply(): boolean;
            set powerSupply(val: boolean);
            get has_history(): boolean;
            set has_history(val: boolean);
            get hasHistory(): boolean;
            set hasHistory(val: boolean);
            get has_statistics(): boolean;
            set has_statistics(val: boolean);
            get hasStatistics(): boolean;
            set hasStatistics(val: boolean);
            get online(): boolean;
            set online(val: boolean);
            get energy(): number;
            set energy(val: number);
            get energy_empty(): number;
            set energy_empty(val: number);
            get energyEmpty(): number;
            set energyEmpty(val: number);
            get energy_full(): number;
            set energy_full(val: number);
            get energyFull(): number;
            set energyFull(val: number);
            get energy_full_design(): number;
            set energy_full_design(val: number);
            get energyFullDesign(): number;
            set energyFullDesign(val: number);
            get energy_rate(): number;
            set energy_rate(val: number);
            get energyRate(): number;
            set energyRate(val: number);
            get voltage(): number;
            set voltage(val: number);
            get charge_cycles(): number;
            set charge_cycles(val: number);
            get chargeCycles(): number;
            set chargeCycles(val: number);
            get luminosity(): number;
            set luminosity(val: number);
            get time_to_empty(): number;
            set time_to_empty(val: number);
            get timeToEmpty(): number;
            set timeToEmpty(val: number);
            get time_to_full(): number;
            set time_to_full(val: number);
            get timeToFull(): number;
            set timeToFull(val: number);
            get percentage(): number;
            set percentage(val: number);
            get temperature(): number;
            set temperature(val: number);
            get is_present(): boolean;
            set is_present(val: boolean);
            get isPresent(): boolean;
            set isPresent(val: boolean);
            get state(): State;
            set state(val: State);
            get is_rechargable(): boolean;
            set is_rechargable(val: boolean);
            get isRechargable(): boolean;
            set isRechargable(val: boolean);
            get capacity(): number;
            set capacity(val: number);
            get technology(): Technology;
            set technology(val: Technology);
            get warning_level(): WarningLevel;
            set warning_level(val: WarningLevel);
            get warningLevel(): WarningLevel;
            set warningLevel(val: WarningLevel);
            get battery_level(): BatteryLevel;
            set battery_level(val: BatteryLevel);
            get batteryLevel(): BatteryLevel;
            set batteryLevel(val: BatteryLevel);
            get icon_name(): string;
            set icon_name(val: string);
            get iconName(): string;
            set iconName(val: string);
            get charging(): boolean;
            set charging(val: boolean);
            get is_battery(): boolean;
            set is_battery(val: boolean);
            get isBattery(): boolean;
            set isBattery(val: boolean);
            get battery_icon_name(): string;
            set battery_icon_name(val: string);
            get batteryIconName(): string;
            set batteryIconName(val: string);
            get device_type_name(): string;
            set device_type_name(val: string);
            get deviceTypeName(): string;
            set deviceTypeName(val: string);
            get device_type_icon(): string;
            set device_type_icon(val: string);
            get deviceTypeIcon(): string;
            set deviceTypeIcon(val: string);

            // Constructors

            constructor(properties?: Partial<Device.ConstructorProps>, ...args: any[]);

            _init(...args: any[]): void;

            static ['new'](path: string): Device;

            // Static methods

            static get_default(): Device | null;

            // Methods

            sync(): void;
            get_device_type(): Type;
            get_native_path(): string;
            get_vendor(): string;
            get_model(): string;
            get_serial(): string;
            get_update_time(): number;
            get_power_supply(): boolean;
            get_has_history(): boolean;
            get_has_statistics(): boolean;
            get_online(): boolean;
            get_energy(): number;
            get_energy_empty(): number;
            get_energy_full(): number;
            get_energy_full_design(): number;
            get_energy_rate(): number;
            get_voltage(): number;
            get_charge_cycles(): number;
            get_luminosity(): number;
            get_time_to_empty(): number;
            get_time_to_full(): number;
            get_percentage(): number;
            get_temperature(): number;
            get_is_present(): boolean;
            get_state(): State;
            get_is_rechargable(): boolean;
            get_capacity(): number;
            get_technology(): Technology;
            get_warning_level(): WarningLevel;
            get_battery_level(): BatteryLevel;
            get_icon_name(): string;
            get_charging(): boolean;
            get_is_battery(): boolean;
            get_battery_icon_name(): string;
            get_device_type_name(): string;
            get_device_type_icon(): string;
        }

        module UPower {
            // Signal callback interfaces

            interface DeviceAdded {
                (device: Device): void;
            }

            interface DeviceRemoved {
                (device: Device): void;
            }

            // Constructor properties interface

            interface ConstructorProps extends GObject.Object.ConstructorProps {
                devices: Device[];
                display_device: Device;
                displayDevice: Device;
                daemon_version: string;
                daemonVersion: string;
                on_battery: boolean;
                onBattery: boolean;
                lid_is_closed: boolean;
                lidIsClosed: boolean;
                lis_is_present: boolean;
                lisIsPresent: boolean;
                critical_action: string;
                criticalAction: string;
            }
        }

        class UPower extends GObject.Object {
            static $gtype: GObject.GType<UPower>;

            // Properties

            get devices(): Device[];
            get display_device(): Device;
            get displayDevice(): Device;
            get daemon_version(): string;
            get daemonVersion(): string;
            get on_battery(): boolean;
            get onBattery(): boolean;
            get lid_is_closed(): boolean;
            get lidIsClosed(): boolean;
            get lis_is_present(): boolean;
            get lisIsPresent(): boolean;
            get critical_action(): string;
            get criticalAction(): string;

            // Constructors

            constructor(properties?: Partial<UPower.ConstructorProps>, ...args: any[]);

            _init(...args: any[]): void;

            static ['new'](): UPower;

            // Signals

            connect(id: string, callback: (...args: any[]) => any): number;
            connect_after(id: string, callback: (...args: any[]) => any): number;
            emit(id: string, ...args: any[]): void;
            connect(signal: 'device-added', callback: (_source: this, device: Device) => void): number;
            connect_after(signal: 'device-added', callback: (_source: this, device: Device) => void): number;
            emit(signal: 'device-added', device: Device): void;
            connect(signal: 'device-removed', callback: (_source: this, device: Device) => void): number;
            connect_after(signal: 'device-removed', callback: (_source: this, device: Device) => void): number;
            emit(signal: 'device-removed', device: Device): void;

            // Methods

            get_devices(): Device[];
            get_display_device(): Device;
            get_daemon_version(): string;
            get_on_battery(): boolean;
            get_lid_is_closed(): boolean;
            get_lis_is_present(): boolean;
            get_critical_action(): string;
        }

        type DeviceClass = typeof Device;
        abstract class DevicePrivate {
            static $gtype: GObject.GType<DevicePrivate>;

            // Constructors

            _init(...args: any[]): void;
        }

        type UPowerClass = typeof UPower;
        abstract class UPowerPrivate {
            static $gtype: GObject.GType<UPowerPrivate>;

            // Constructors

            _init(...args: any[]): void;
        }

        type IUPowerDeviceIface = typeof IUPowerDevice;
        class HistoryDataPoint {
            static $gtype: GObject.GType<HistoryDataPoint>;

            // Fields

            time: number;
            value: number;
            state: number;

            // Constructors

            constructor(
                properties?: Partial<{
                    time: number;
                    value: number;
                    state: number;
                }>,
            );
            _init(...args: any[]): void;
        }

        class StatisticsDataPoint {
            static $gtype: GObject.GType<StatisticsDataPoint>;

            // Fields

            value: number;
            accuracy: number;

            // Constructors

            constructor(
                properties?: Partial<{
                    value: number;
                    accuracy: number;
                }>,
            );
            _init(...args: any[]): void;
        }

        module IUPowerDevice {
            // Constructor properties interface

            interface ConstructorProps extends Gio.DBusProxy.ConstructorProps {}
        }

        export interface IUPowerDeviceNamespace {
            $gtype: GObject.GType<IUPowerDevice>;
            prototype: IUPowerDevice;
        }
        interface IUPowerDevice extends Gio.DBusProxy {
            // Methods

            get_history(type: string, timespan: number, resolution: number): HistoryDataPoint[];
            get_statistics(type: string): StatisticsDataPoint[];
            refresh(): void;
            get_Type(): number;
            get_native_path(): string;
            get_vendor(): string;
            get_model(): string;
            get_serial(): string;
            get_update_time(): number;
            get_power_supply(): boolean;
            get_has_history(): boolean;
            get_has_statistics(): boolean;
            get_online(): boolean;
            get_energy(): number;
            get_energy_empty(): number;
            get_energy_full(): number;
            get_energy_full_design(): number;
            get_energy_rate(): number;
            get_voltage(): number;
            get_charge_cycles(): number;
            get_luminosity(): number;
            get_time_to_empty(): number;
            get_time_to_full(): number;
            get_percentage(): number;
            get_temperature(): number;
            get_is_present(): boolean;
            get_state(): number;
            get_is_rechargable(): boolean;
            get_capacity(): number;
            get_technology(): number;
            get_warning_level(): number;
            get_battery_level(): number;
            get_icon_name(): string;

            // Virtual methods

            vfunc_get_history(type: string, timespan: number, resolution: number): HistoryDataPoint[];
            vfunc_get_statistics(type: string): StatisticsDataPoint[];
            vfunc_refresh(): void;
            vfunc_get_Type(): number;
            vfunc_get_native_path(): string;
            vfunc_get_vendor(): string;
            vfunc_get_model(): string;
            vfunc_get_serial(): string;
            vfunc_get_update_time(): number;
            vfunc_get_power_supply(): boolean;
            vfunc_get_has_history(): boolean;
            vfunc_get_has_statistics(): boolean;
            vfunc_get_online(): boolean;
            vfunc_get_energy(): number;
            vfunc_get_energy_empty(): number;
            vfunc_get_energy_full(): number;
            vfunc_get_energy_full_design(): number;
            vfunc_get_energy_rate(): number;
            vfunc_get_voltage(): number;
            vfunc_get_charge_cycles(): number;
            vfunc_get_luminosity(): number;
            vfunc_get_time_to_empty(): number;
            vfunc_get_time_to_full(): number;
            vfunc_get_percentage(): number;
            vfunc_get_temperature(): number;
            vfunc_get_is_present(): boolean;
            vfunc_get_state(): number;
            vfunc_get_is_rechargable(): boolean;
            vfunc_get_capacity(): number;
            vfunc_get_technology(): number;
            vfunc_get_warning_level(): number;
            vfunc_get_battery_level(): number;
            vfunc_get_icon_name(): string;
        }

        export const IUPowerDevice: IUPowerDeviceNamespace;

        /**
         * Name of the imported GIR library
         * `see` https://gitlab.gnome.org/GNOME/gjs/-/blob/master/gi/ns.cpp#L188
         */
        const __name__: string;
        /**
         * Version of the imported GIR library
         * `see` https://gitlab.gnome.org/GNOME/gjs/-/blob/master/gi/ns.cpp#L189
         */
        const __version__: string;
    }

    export default AstalBattery;
}

declare module 'gi://AstalBattery' {
    import AstalBattery01 from 'gi://AstalBattery?version=0.1';
    export default AstalBattery01;
}
// END
