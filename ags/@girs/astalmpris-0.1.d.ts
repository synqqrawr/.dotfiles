/// <reference path="./glib-2.0.d.ts" />
/// <reference path="./gobject-2.0.d.ts" />

/**
 * Type Definitions for Gjs (https://gjs.guide/)
 *
 * These type definitions are automatically generated, do not edit them by hand.
 * If you found a bug fix it in `ts-for-gir` or create a bug report on https://github.com/gjsify/ts-for-gir
 *
 * The based EJS template file is used for the generated .d.ts file of each GIR module like Gtk-4.0, GObject-2.0, ...
 */

declare module 'gi://AstalMpris?version=0.1' {
    // Module dependencies
    import type GLib from 'gi://GLib?version=2.0';
    import type GObject from 'gi://GObject?version=2.0';

    export namespace AstalMpris {
        /**
         * AstalMpris-0.1
         */

        export namespace PlaybackStatus {
            export const $gtype: GObject.GType<PlaybackStatus>;
        }

        enum PlaybackStatus {
            PLAYING,
            PAUSED,
            STOPPED,
        }

        export namespace Loop {
            export const $gtype: GObject.GType<Loop>;
        }

        enum Loop {
            UNSUPPORTED,
            NONE,
            TRACK,
            PLAYLIST,
        }

        export namespace Shuffle {
            export const $gtype: GObject.GType<Shuffle>;
        }

        enum Shuffle {
            UNSUPPORTED,
            ON,
            OFF,
        }
        const MAJOR_VERSION: number;
        const MINOR_VERSION: number;
        const MICRO_VERSION: number;
        const VERSION: string;
        function playback_status_from_string(str?: string | null): PlaybackStatus;
        function playback_status_to_string(): string;
        function loop_from_string(str?: string | null): Loop;
        function loop_to_string(): string | null;
        function shuffle_from_bool(b: boolean): Shuffle;
        function shuffle_to_string(): string | null;
        function get_default(): Mpris;
        module Player {
            // Signal callback interfaces

            interface Appeared {
                (): void;
            }

            interface Closed {
                (): void;
            }

            interface Seeked {
                (position: number): void;
            }

            // Constructor properties interface

            interface ConstructorProps extends GObject.Object.ConstructorProps {
                bus_name: string;
                busName: string;
                available: boolean;
                can_quit: boolean;
                canQuit: boolean;
                fullscreen: boolean;
                can_set_fullscreen: boolean;
                canSetFullscreen: boolean;
                can_raise: boolean;
                canRaise: boolean;
                has_track_list: boolean;
                hasTrackList: boolean;
                identity: string;
                entry: string;
                supported_uri_schemas: string[];
                supportedUriSchemas: string[];
                supported_mime_types: string[];
                supportedMimeTypes: string[];
                loop_status: Loop;
                loopStatus: Loop;
                rate: number;
                shuffle_status: Shuffle;
                shuffleStatus: Shuffle;
                volume: number;
                position: number;
                playback_status: PlaybackStatus;
                playbackStatus: PlaybackStatus;
                minimum_rate: number;
                minimumRate: number;
                maximum_rate: number;
                maximumRate: number;
                can_go_next: boolean;
                canGoNext: boolean;
                can_go_previous: boolean;
                canGoPrevious: boolean;
                can_play: boolean;
                canPlay: boolean;
                can_pause: boolean;
                canPause: boolean;
                can_seek: boolean;
                canSeek: boolean;
                can_control: boolean;
                canControl: boolean;
                metadata: GLib.HashTable<string, GLib.Variant>;
                trackid: string;
                length: number;
                art_url: string;
                artUrl: string;
                album: string;
                album_artist: string;
                albumArtist: string;
                artist: string;
                lyrics: string;
                title: string;
                composer: string;
                comments: string;
                cover_art: string;
                coverArt: string;
            }
        }

        class Player extends GObject.Object {
            static $gtype: GObject.GType<Player>;

            // Properties

            get bus_name(): string;
            set bus_name(val: string);
            get busName(): string;
            set busName(val: string);
            get available(): boolean;
            set available(val: boolean);
            get can_quit(): boolean;
            set can_quit(val: boolean);
            get canQuit(): boolean;
            set canQuit(val: boolean);
            get fullscreen(): boolean;
            set fullscreen(val: boolean);
            get can_set_fullscreen(): boolean;
            set can_set_fullscreen(val: boolean);
            get canSetFullscreen(): boolean;
            set canSetFullscreen(val: boolean);
            get can_raise(): boolean;
            set can_raise(val: boolean);
            get canRaise(): boolean;
            set canRaise(val: boolean);
            get has_track_list(): boolean;
            set has_track_list(val: boolean);
            get hasTrackList(): boolean;
            set hasTrackList(val: boolean);
            get identity(): string;
            set identity(val: string);
            get entry(): string;
            set entry(val: string);
            get supported_uri_schemas(): string[];
            set supported_uri_schemas(val: string[]);
            get supportedUriSchemas(): string[];
            set supportedUriSchemas(val: string[]);
            get supported_mime_types(): string[];
            set supported_mime_types(val: string[]);
            get supportedMimeTypes(): string[];
            set supportedMimeTypes(val: string[]);
            get loop_status(): Loop;
            set loop_status(val: Loop);
            get loopStatus(): Loop;
            set loopStatus(val: Loop);
            get rate(): number;
            set rate(val: number);
            get shuffle_status(): Shuffle;
            set shuffle_status(val: Shuffle);
            get shuffleStatus(): Shuffle;
            set shuffleStatus(val: Shuffle);
            get volume(): number;
            set volume(val: number);
            get position(): number;
            set position(val: number);
            get playback_status(): PlaybackStatus;
            set playback_status(val: PlaybackStatus);
            get playbackStatus(): PlaybackStatus;
            set playbackStatus(val: PlaybackStatus);
            get minimum_rate(): number;
            set minimum_rate(val: number);
            get minimumRate(): number;
            set minimumRate(val: number);
            get maximum_rate(): number;
            set maximum_rate(val: number);
            get maximumRate(): number;
            set maximumRate(val: number);
            get can_go_next(): boolean;
            set can_go_next(val: boolean);
            get canGoNext(): boolean;
            set canGoNext(val: boolean);
            get can_go_previous(): boolean;
            set can_go_previous(val: boolean);
            get canGoPrevious(): boolean;
            set canGoPrevious(val: boolean);
            get can_play(): boolean;
            set can_play(val: boolean);
            get canPlay(): boolean;
            set canPlay(val: boolean);
            get can_pause(): boolean;
            set can_pause(val: boolean);
            get canPause(): boolean;
            set canPause(val: boolean);
            get can_seek(): boolean;
            set can_seek(val: boolean);
            get canSeek(): boolean;
            set canSeek(val: boolean);
            get can_control(): boolean;
            set can_control(val: boolean);
            get canControl(): boolean;
            set canControl(val: boolean);
            get metadata(): GLib.HashTable<string, GLib.Variant>;
            set metadata(val: GLib.HashTable<string, GLib.Variant>);
            get trackid(): string;
            set trackid(val: string);
            get length(): number;
            set length(val: number);
            get art_url(): string;
            set art_url(val: string);
            get artUrl(): string;
            set artUrl(val: string);
            get album(): string;
            set album(val: string);
            get album_artist(): string;
            set album_artist(val: string);
            get albumArtist(): string;
            set albumArtist(val: string);
            get artist(): string;
            set artist(val: string);
            get lyrics(): string;
            set lyrics(val: string);
            get title(): string;
            set title(val: string);
            get composer(): string;
            set composer(val: string);
            get comments(): string;
            set comments(val: string);
            get cover_art(): string;
            set cover_art(val: string);
            get coverArt(): string;
            set coverArt(val: string);

            // Constructors

            constructor(properties?: Partial<Player.ConstructorProps>, ...args: any[]);

            _init(...args: any[]): void;

            static ['new'](name: string): Player;

            // Signals

            connect(id: string, callback: (...args: any[]) => any): number;
            connect_after(id: string, callback: (...args: any[]) => any): number;
            emit(id: string, ...args: any[]): void;
            connect(signal: 'appeared', callback: (_source: this) => void): number;
            connect_after(signal: 'appeared', callback: (_source: this) => void): number;
            emit(signal: 'appeared'): void;
            connect(signal: 'closed', callback: (_source: this) => void): number;
            connect_after(signal: 'closed', callback: (_source: this) => void): number;
            emit(signal: 'closed'): void;
            connect(signal: 'seeked', callback: (_source: this, position: number) => void): number;
            connect_after(signal: 'seeked', callback: (_source: this, position: number) => void): number;
            emit(signal: 'seeked', position: number): void;

            // Methods

            raise(): void;
            quit(): void;
            toggle_fullscreen(): void;
            next(): void;
            previous(): void;
            pause(): void;
            play_pause(): void;
            stop(): void;
            play(): void;
            open_uri(uri: string): void;
            loop(): void;
            shuffle(): void;
            _get_position(): number;
            get_meta(key: string): GLib.Variant | null;
            try_proxy(): void;
            get_bus_name(): string;
            set_bus_name(value: string): void;
            get_available(): boolean;
            get_can_quit(): boolean;
            get_fullscreen(): boolean;
            get_can_set_fullscreen(): boolean;
            get_can_raise(): boolean;
            get_has_track_list(): boolean;
            get_identity(): string;
            get_entry(): string;
            get_supported_uri_schemas(): string[];
            get_supported_mime_types(): string[];
            get_loop_status(): Loop;
            set_loop_status(value: Loop): void;
            get_rate(): number;
            set_rate(value: number): void;
            get_shuffle_status(): Shuffle;
            set_shuffle_status(value: Shuffle): void;
            get_volume(): number;
            set_volume(value: number): void;
            get_position(): number;
            set_position(value: number): void;
            get_playback_status(): PlaybackStatus;
            get_minimum_rate(): number;
            get_maximum_rate(): number;
            get_can_go_next(): boolean;
            get_can_go_previous(): boolean;
            get_can_play(): boolean;
            get_can_pause(): boolean;
            get_can_seek(): boolean;
            get_can_control(): boolean;
            get_metadata(): GLib.HashTable<string, GLib.Variant>;
            get_trackid(): string;
            get_length(): number;
            get_art_url(): string;
            get_album(): string;
            get_album_artist(): string;
            get_artist(): string;
            get_lyrics(): string;
            get_title(): string;
            get_composer(): string;
            get_comments(): string;
            get_cover_art(): string;
        }

        module Mpris {
            // Signal callback interfaces

            interface PlayerAdded {
                (player: Player): void;
            }

            interface PlayerClosed {
                (player: Player): void;
            }

            // Constructor properties interface

            interface ConstructorProps extends GObject.Object.ConstructorProps {
                players: Player[];
            }
        }

        class Mpris extends GObject.Object {
            static $gtype: GObject.GType<Mpris>;

            // Properties

            get players(): Player[];

            // Constructors

            constructor(properties?: Partial<Mpris.ConstructorProps>, ...args: any[]);

            _init(...args: any[]): void;

            static ['new'](): Mpris;

            // Signals

            connect(id: string, callback: (...args: any[]) => any): number;
            connect_after(id: string, callback: (...args: any[]) => any): number;
            emit(id: string, ...args: any[]): void;
            connect(signal: 'player-added', callback: (_source: this, player: Player) => void): number;
            connect_after(signal: 'player-added', callback: (_source: this, player: Player) => void): number;
            emit(signal: 'player-added', player: Player): void;
            connect(signal: 'player-closed', callback: (_source: this, player: Player) => void): number;
            connect_after(signal: 'player-closed', callback: (_source: this, player: Player) => void): number;
            emit(signal: 'player-closed', player: Player): void;

            // Static methods

            static get_default(): Mpris;

            // Methods

            get_players(): Player[];
        }

        type PlayerClass = typeof Player;
        abstract class PlayerPrivate {
            static $gtype: GObject.GType<PlayerPrivate>;

            // Constructors

            _init(...args: any[]): void;
        }

        type MprisClass = typeof Mpris;
        abstract class MprisPrivate {
            static $gtype: GObject.GType<MprisPrivate>;

            // Constructors

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

    export default AstalMpris;
}

declare module 'gi://AstalMpris' {
    import AstalMpris01 from 'gi://AstalMpris?version=0.1';
    export default AstalMpris01;
}
// END
