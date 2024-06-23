

resource "azurerm_resource_group" "example" {
  name     = "cloudcomputing-resources"
  location = "East US"
}

resource "azurerm_service_plan" "example" {
  name                = "cloudcomputing-appserviceplan"
  location            = azurerm_resource_group.example.location
  resource_group_name = azurerm_resource_group.example.name
  os_type             = "Linux"

  sku_name = "B1" # F1 (Kostenlos) -> 60 CPU-Minuten/Tag  B1 ($0,075/Stunde) -> 1,75 GB RAM / 10 GB Speicher / 1 Kern 

}

resource "azurerm_linux_web_app" "example" {
  name                = "cloudcomputing-linux-web-app"
  location            = azurerm_resource_group.example.location
  resource_group_name = azurerm_resource_group.example.name
  service_plan_id     = azurerm_service_plan.example.id

  site_config {
    
    always_on = false
    # app_command_line = "gunicorn -w 4 -b :8000 Python_Web_App.app:app" -> Kein Startbefehl benötigt
    
    application_stack {
      python_version = 3.9
    }
  }
}


resource "azurerm_app_service_source_control" "example" {
  app_id   = azurerm_linux_web_app.example.id
  repo_url = "https://github.com/samuelgoetz/Python_Web-App"
  branch   = "main"

  # code_configuration {
  #   runtime_stack = "python"
  #   runtime_version = "3.9"
  # }

}


resource "azurerm_source_control_token" "example" {
    type  = "GitHub"
    token = "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" # PAT from GitHub
}




# app_command_line

# -w 4: Dies gibt an, dass Gunicorn mit 4 Worker-Prozessen arbeiten soll. Worker-Prozesse bearbeiten eingehende HTTP-Anfragen. Mehr Worker können die Leistung verbessern, indem sie die gleichzeitige Verarbeitung von Anfragen ermöglichen.

# -b :8000: Dies gibt an, dass Gunicorn auf Port 8000 an alle Netzwerk-Schnittstellen gebunden wird (localhost und andere IP-Adressen). :8000 bedeutet "alle Schnittstellen" (vor dem Doppelpunkt) und Port 8000 (nach dem Doppelpunkt).


#  Python_Web_App.app:app"

# Die Struktur Ihrer Anwendung sollte dann wie folgt aussehen:

# Python_Web_App/
# │
# ├── app.py
# │   └── (Inhalt der Datei app.py, z.B. die Flask-Anwendung)
# │
# └── (eventuell weitere Dateien und Ordner)
























