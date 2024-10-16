/// <reference path="./gio-2.0.d.ts" />
/// <reference path="./gobject-2.0.d.ts" />
/// <reference path="./glib-2.0.d.ts" />
/// <reference path="./gmodule-2.0.d.ts" />
/// <reference path="./gdkpixbuf-2.0.d.ts" />
/// <reference path="./gtk-3.0.d.ts" />
/// <reference path="./xlib-2.0.d.ts" />
/// <reference path="./gdk-3.0.d.ts" />
/// <reference path="./cairo-1.0.d.ts" />
/// <reference path="./pango-1.0.d.ts" />
/// <reference path="./harfbuzz-0.0.d.ts" />
/// <reference path="./freetype2-2.0.d.ts" />
/// <reference path="./atk-1.0.d.ts" />

/**
 * Type Definitions for Gjs (https://gjs.guide/)
 *
 * These type definitions are automatically generated, do not edit them by hand.
 * If you found a bug fix it in `ts-for-gir` or create a bug report on https://github.com/gjsify/ts-for-gir
 *
 * The based EJS template file is used for the generated .d.ts file of each GIR module like Gtk-4.0, GObject-2.0, ...
 */

declare module 'gi://AstalTray?version=0.1' {
    // Module dependencies
    import type Gio from 'gi://Gio?version=2.0';
    import type GObject from 'gi://GObject?version=2.0';
    import type GLib from 'gi://GLib?version=2.0';
    import type GModule from 'gi://GModule?version=2.0';
    import type GdkPixbuf from 'gi://GdkPixbuf?version=2.0';
    import type Gtk from 'gi://Gtk?version=3.0';
    import type xlib from 'gi://xlib?version=2.0';
    import type Gdk from 'gi://Gdk?version=3.0';
    import type cairo from 'gi://cairo?version=1.0';
    import type Pango from 'gi://Pango?version=1.0';
    import type HarfBuzz from 'gi://HarfBuzz?version=0.0';
    import type freetype2 from 'gi://freetype2?version=2.0';
    import type Atk from 'gi://Atk?version=1.0';

    export namespace AstalTray {
        /**
         * AstalTray-0.1
         */

        export namespace Category {
            export const $gtype: GObject.GType<Category>;
        }

        enum Category {
            APPLICATION,
            COMMUNICATIONS,
            SYSTEM,
            HARDWARE,
        }

        export namespace Status {
            export const $gtype: GObject.GType<Status>;
        }

        enum Status {
            PASSIVE,
            ACTIVE,
            NEEDS_ATTENTION,
        }
        const MAJOR_VERSION: number;
        const MINOR_VERSION: number;
        const MICRO_VERSION: number;
        const VERSION: string;
        function category_to_nick(): string;
        function status_to_nick(): string;
        function get_default(): Tray;
        module Tray {
            // Signal callback interfaces

            interface ItemAdded {
                (service: string): void;
            }

            interface ItemRemoved {
                (service: string): void;
            }

            // Constructor properties interface

            interface ConstructorProps extends GObject.Object.ConstructorProps {
                items: TrayItem[];
            }
        }

        class Tray extends GObject.Object {
            static $gtype: GObject.GType<Tray>;

            // Properties

            get items(): TrayItem[];

            // Constructors

            constructor(properties?: Partial<Tray.ConstructorProps>, ...args: any[]);

            _init(...args: any[]): void;

            static ['new'](): Tray;

            // Signals

            connect(id: string, callback: (...args: any[]) => any): number;
            connect_after(id: string, callback: (...args: any[]) => any): number;
            emit(id: string, ...args: any[]): void;
            connect(signal: 'item-added', callback: (_source: this, service: string) => void): number;
            connect_after(signal: 'item-added', callback: (_source: this, service: string) => void): number;
            emit(signal: 'item-added', service: string): void;
            connect(signal: 'item-removed', callback: (_source: this, service: string) => void): number;
            connect_after(signal: 'item-removed', callback: (_source: this, service: string) => void): number;
            emit(signal: 'item-removed', service: string): void;

            // Static methods

            static get_default(): Tray;

            // Methods

            get_item(service: string): TrayItem;
            get_items(): TrayItem[];
        }

        module TrayItem {
            // Signal callback interfaces

            interface Changed {
                (): void;
            }

            interface Ready {
                (): void;
            }

            // Constructor properties interface

            interface ConstructorProps extends GObject.Object.ConstructorProps {
                title: string;
                category: Category;
                status: Status;
                tooltip: Tooltip;
                tooltip_markup: string;
                tooltipMarkup: string;
                id: string;
                icon_theme_path: string;
                iconThemePath: string;
                is_menu: boolean;
                isMenu: boolean;
                icon_name: string;
                iconName: string;
                icon_pixbuf: GdkPixbuf.Pixbuf;
                iconPixbuf: GdkPixbuf.Pixbuf;
                gicon: Gio.Icon;
                item_id: string;
                itemId: string;
            }
        }

        class TrayItem extends GObject.Object {
            static $gtype: GObject.GType<TrayItem>;

            // Properties

            get title(): string;
            get category(): Category;
            get status(): Status;
            get tooltip(): Tooltip;
            get tooltip_markup(): string;
            get tooltipMarkup(): string;
            get id(): string;
            get icon_theme_path(): string;
            get iconThemePath(): string;
            get is_menu(): boolean;
            get isMenu(): boolean;
            get icon_name(): string;
            get iconName(): string;
            get icon_pixbuf(): GdkPixbuf.Pixbuf;
            get iconPixbuf(): GdkPixbuf.Pixbuf;
            get gicon(): Gio.Icon;
            set gicon(val: Gio.Icon);
            get item_id(): string;
            set item_id(val: string);
            get itemId(): string;
            set itemId(val: string);

            // Constructors

            constructor(properties?: Partial<TrayItem.ConstructorProps>, ...args: any[]);

            _init(...args: any[]): void;

            static ['new'](service: string, path: string): TrayItem;

            // Signals

            connect(id: string, callback: (...args: any[]) => any): number;
            connect_after(id: string, callback: (...args: any[]) => any): number;
            emit(id: string, ...args: any[]): void;
            connect(signal: 'changed', callback: (_source: this) => void): number;
            connect_after(signal: 'changed', callback: (_source: this) => void): number;
            emit(signal: 'changed'): void;
            connect(signal: 'ready', callback: (_source: this) => void): number;
            connect_after(signal: 'ready', callback: (_source: this) => void): number;
            emit(signal: 'ready'): void;

            // Methods

            activate(x: number, y: number): void;
            secondary_activate(x: number, y: number): void;
            scroll(delta: number, orientation: string): void;
            create_menu(): Gtk.Menu | null;
            _get_icon_pixbuf(): GdkPixbuf.Pixbuf | null;
            to_json_string(): string;
            get_title(): string;
            get_category(): Category;
            get_status(): Status;
            get_tooltip(): Tooltip | null;
            get_tooltip_markup(): string;
            get_id(): string;
            get_icon_theme_path(): string;
            get_is_menu(): boolean;
            get_icon_name(): string;
            get_icon_pixbuf(): GdkPixbuf.Pixbuf;
            get_gicon(): Gio.Icon;
            get_item_id(): string;
        }

        type TrayClass = typeof Tray;
        abstract class TrayPrivate {
            static $gtype: GObject.GType<TrayPrivate>;

            // Constructors

            _init(...args: any[]): void;
        }

        type TrayItemClass = typeof TrayItem;
        abstract class TrayItemPrivate {
            static $gtype: GObject.GType<TrayItemPrivate>;

            // Constructors

            _init(...args: any[]): void;
        }

        class Pixmap {
            static $gtype: GObject.GType<Pixmap>;

            // Fields

            width: number;
            height: number;
            bytes: Uint8Array;
            bytes_length1: number;

            // Constructors

            constructor(
                properties?: Partial<{
                    width: number;
                    height: number;
                    bytes: Uint8Array;
                    bytes_length1: number;
                }>,
            );
            _init(...args: any[]): void;
        }

        class Tooltip {
            static $gtype: GObject.GType<Tooltip>;

            // Fields

            icon_name: string;
            icon: Pixmap[];
            icon_length1: number;
            title: string;
            description: string;

            // Constructors

            constructor(
                properties?: Partial<{
                    icon_name: string;
                    icon: Pixmap[];
                    icon_length1: number;
                    title: string;
                    description: string;
                }>,
            );
            _init(...args: any[]): void;
        }

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

    export default AstalTray;
}

declare module 'gi://AstalTray' {
    import AstalTray01 from 'gi://AstalTray?version=0.1';
    export default AstalTray01;
}
// END
