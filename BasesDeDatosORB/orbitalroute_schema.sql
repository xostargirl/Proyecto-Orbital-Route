-- Esquema relacional propuesto para OrbitalRoute AI
PRAGMA foreign_keys = ON;

CREATE TABLE IF NOT EXISTS satellites (
    satellite_id TEXT PRIMARY KEY,
    norad_cat_id TEXT UNIQUE,
    object_name TEXT,
    object_id TEXT,
    constellation TEXT
);

CREATE TABLE IF NOT EXISTS orbital_data (
    orbital_data_id INTEGER PRIMARY KEY AUTOINCREMENT,
    satellite_id TEXT NOT NULL,
    epoch TEXT,
    inclination REAL,
    ra_of_asc_node REAL,
    eccentricity REAL,
    arg_of_pericenter REAL,
    mean_anomaly REAL,
    mean_motion REAL,
    bstar REAL,
    rev_at_epoch INTEGER,
    source TEXT,
    downloaded_at_utc TEXT,
    FOREIGN KEY (satellite_id) REFERENCES satellites(satellite_id)
);

CREATE TABLE IF NOT EXISTS links (
    link_id TEXT PRIMARY KEY,
    link_source_id TEXT NOT NULL,
    link_destination_id TEXT NOT NULL,
    distance_km REAL,
    link_status TEXT,
    timestamp_utc TEXT,
    FOREIGN KEY (link_source_id) REFERENCES satellites(satellite_id),
    FOREIGN KEY (link_destination_id) REFERENCES satellites(satellite_id)
);

CREATE TABLE IF NOT EXISTS qos_metrics (
    metric_id TEXT PRIMARY KEY,
    link_id TEXT NOT NULL,
    timestamp_utc TEXT,
    latency_ms REAL,
    packet_loss_rate REAL,
    availability_rate REAL,
    algorithm_used TEXT,
    measurement_type TEXT,
    FOREIGN KEY (link_id) REFERENCES links(link_id)
);
