// Required Notice: Copyright 2026 Moussa Jammoul (https://github.com/moussa-jammoul/campus-local-frontend)
// Licensed under the PolyForm Noncommercial License 1.0.0.
// See LICENSE.md in the project root or https://polyformproject.org/licenses/noncommercial/1.0.0 for full terms.
const int qRCODEVERSIONPROTOCOL = 1;
const int protocolVersionMDNS = 1;
const String serviceType = '_d2dshare._tcp'; 
const firstScanSeconds = 60; // waiting for the QR scan
const idleSeconds = 300;      // gap between two requests , used to auto-abort the server