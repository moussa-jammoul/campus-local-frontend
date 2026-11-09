const int qRCODEVERSIONPROTOCOL = 1;
const int protocolVersionMDNS = 1;
const String serviceType = '_d2dshare._tcp'; 
const firstScanSeconds = 60; // waiting for the QR scan
const idleSeconds = 300;      // gap between two requests , used to auto-abort the server