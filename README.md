# investmestdecisiondemo
BACKEND in 3 Teilen:
requirements.txt: alle benötigten Bibliotheken
LSTM & ARIMA : Algorithmen - Daten analysieren
main.py: API für Flutter aufzurufen

zu implementieren :FRONTEND: Flutter ?
main.dart
pubspec.yaml: benötigte Bib bei dart
stock_model.dart
api_service.dart

UPDATE 05.08.06:FRONTEND

## 🚀 Hauptfunktionen

- 🔄 **Echtzeit-Datenaggregation:** Anbindung an die AlphaVantage-API zur Erfassung historischer Zeitreihendaten von Aktienkursen.
- 🤖 **Hybride ML-Analyse:** Kombination aus Kurzfrist-Prognosen via **ARIMA** (Autoregressive Integrated Moving Average) und neuronalen Netzen via **LSTM** (Long Short-Term Memory).
- 📊 **Intuitiver Trendvisualisierung:** Interaktive und übersichtliche Diagrammdarstellung mittels `fl_chart`.
- 📱 **Plattformübergreifend:** Professionelles Dark-Theme-UI für Android und iOS.

---

## 🛠 Verwendete Technologien & Bibliotheken

### **Backend (Python)**
- **FastAPI / Uvicorn:** Hochleistungs-REST-API-Server.
- **Statsmodels:** Berechnung und Modellierung von ARIMA-Zeitreihen.
- **TensorFlow / Scikit-learn:** Training und Inferenz von LSTM-Modellen.
- **Pandas / NumPy:** Effiziente Verarbeitung und Normalisierung von Finanzdaten.

### **Frontend (Flutter)**
- **Flutter SDK:** Entwicklung der plattformübergreifenden mobilen Oberfläche.
- **HTTP:** Kommunikation mit dem Python-Backend über RESTful Services.
- **fl_chart:** Leistungsstarke Bibliothek zur Erstellung mobiler Finanzdiagramme.

---

## 📁 Projektstruktur

```text
stock-analyzer/
├── backend/                  # Python FastAPI Backend
│   ├── analyzer.py           # Machine Learning Logic (ARIMA & LSTM)
│   ├── main.py               # API-Endpunkte & AlphaVantage-Integration
│   └── requirements.txt      # Python-Abhängigkeiten
│
└── frontend/                 # Flutter Mobile Client
    ├── pubspec.yaml          # Flutter-Konfiguration & Dependencies
    └── lib/
        ├── main.dart         # Haupt-UI & Diagrammdarstellung
        ├── models/           # Datenmodelle (StockData)
        └── services/         # API-Client (ApiService)
