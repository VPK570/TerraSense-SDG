<h2 align="center">TerraSense</h2>
<br/>

> A climate-adaptive urban digital twin that simulates flash-flood risk from cloudburst rainfall, turning satellite and hydrology data into ward-level flood maps, evacuation routes, and municipal capital investment recommendations.

> **Note:** This is not the exact repository used during the original hackathon submission. It has been cleaned up, reorganized, and prepared separately for public showcase.

## 🔗 Live Demo

- **Frontend:** [terrasense-wehack.vercel.app](https://terrasense-wehack.vercel.app/)
- **Backend:** [terrasense-wehack-backend.onrender.com](https://terrasense-wehack-backend.onrender.com/api/health)

> The backend is hosted on Render's free tier, which spins down after periods of inactivity. The frontend automatically pings the backend's `/api/health` endpoint as soon as it loads to wake it back up, so the very first request after a period of inactivity may take 30-50 seconds while the server cold-starts — subsequent requests are fast.
>
> **Try the emergency dispatch feature live:** open the deployed frontend, keep the dashboard visible, and call **+1 (701) 747-9169** (the demo's Twilio number) from any phone. The incoming call shows up on the dashboard's live call feed in real time.

## ⚙️ Tech Stack

**Frontend**

- [React](https://react.dev/)
- [Vite](https://vitejs.dev/)
- [Leaflet](https://leafletjs.com/) / [React Leaflet](https://react-leaflet.js.org/)

**Backend**

- [Python](https://www.python.org/)
- [Flask](https://flask.palletsprojects.com/)
- [NumPy](https://numpy.org/) / [Pandas](https://pandas.pydata.org/)
- [Google Earth Engine API](https://earthengine.google.com/)
- [Twilio](https://www.twilio.com/) (emergency SMS & voice dispatch)

**Infra**

- [Vercel](https://vercel.com/) / [Render](https://render.com/) (suggested hosting for frontend/backend)

## 🔧 Features

- **SCS-CN Flood Hydrology Engine**
  Runs the USDA NRCS Curve Number method against rainfall intensity and catchment data to compute runoff volume, peak discharge, and flood extent for a selected ward.

- **Interactive GIS Simulation Map**
  Draw or select a catchment, adjust cloudburst intensity, and see the flood overlay, before/after mitigation comparison, and storm hydrograph update in real time.

- **AI-Assisted Intervention Recommendations**
  Suggests green infrastructure interventions (retention basins, bioswales, permeable surfaces) with estimated cost and runoff reduction impact.

- **Municipal DPR Report Generator**
  Exports a print-ready Detailed Project Report with CPWD Schedule-of-Rates based cost estimates for proposed interventions.

- **Emergency Dispatch Integration**
  Sends SMS alerts and places voice calls through Twilio to notify residents and emergency contacts in high-risk zones.

- **Safe Shelter & Evacuation Routing**
  Identifies high-ground shelters and plots evacuation routes that avoid flood-prone roads.

- **Multi-City Benchmarking**
  Compares flood risk and mitigation impact across multiple pre-loaded Indian cities.

## 🚀 Getting Started

**Backend**

```bash
cd backend
pip install -r requirements-minimal.txt
python app.py
```

**Frontend**

```bash
cd frontend
npm install
npm run dev
```

Copy `.env.example` to `.env` in both `backend/` and `frontend/` and fill in your own API keys before running.

## 🚀 Made with ❤️ by

<table>
<tr align="center">
<td>
	<p align="center">
		<img src="https://github.com/Advik-Gupta.png" width="170" height="170" alt="Advik Gupta" style="border: 2px solid grey; border-radius: 50%;">
	</p>
	<p style="font-size:17px; font-weight:600;">Advik Gupta</p>
	<p align="center">
		<a href="https://github.com/Advik-Gupta">
			<img src="https://img.shields.io/badge/GitHub-181717?style=for-the-badge&logo=github&logoColor=white" alt="GitHub"/>
		</a>
	</p>
</td>
<td>
	<p align="center">
		<img src="https://github.com/Rithish-2914.png" width="170" height="170" alt="Rithish" style="border: 2px solid grey; border-radius: 50%;">
	</p>
	<p style="font-size:17px; font-weight:600;">Rithish</p>
	<p align="center">
		<a href="https://github.com/Rithish-2914">
			<img src="https://img.shields.io/badge/GitHub-181717?style=for-the-badge&logo=github&logoColor=white" alt="GitHub"/>
		</a>
	</p>
</td>
<td>
	<p align="center">
		<img src="https://github.com/zlakio.png" width="170" height="170" alt="zlakio" style="border: 2px solid grey; border-radius: 50%;">
	</p>
	<p style="font-size:17px; font-weight:600;">zlakio</p>
	<p align="center">
		<a href="https://github.com/zlakio">
			<img src="https://img.shields.io/badge/GitHub-181717?style=for-the-badge&logo=github&logoColor=white" alt="GitHub"/>
		</a>
	</p>
</td>
<td>
	<p align="center">
		<img src="https://github.com/harsheta-6.png" width="170" height="170" alt="harsheta-6" style="border: 2px solid grey; border-radius: 50%;">
	</p>
	<p style="font-size:17px; font-weight:600;">harsheta-6</p>
	<p align="center">
		<a href="https://github.com/harsheta-6">
			<img src="https://img.shields.io/badge/GitHub-181717?style=for-the-badge&logo=github&logoColor=white" alt="GitHub"/>
		</a>
	</p>
</td>
<td>
	<p align="center">
		<img src="https://ui-avatars.com/api/?name=Jia+Handa&size=170&background=444&color=fff" width="170" height="170" alt="Jia Handa" style="border: 2px solid grey; border-radius: 50%;">
	</p>
	<p style="font-size:17px; font-weight:600;">Jia Handa</p>
	<p align="center">
		<a href="https://www.linkedin.com/in/jia-handa-0124b83ba/">
			<img src="https://img.shields.io/badge/LinkedIn-0A66C2?style=for-the-badge&logo=linkedin&logoColor=white" alt="LinkedIn"/>
		</a>
	</p>
</td>
</tr>
</table>

#### AI Disclosure

This project was developed with AI assistance. Claude and Antigravity were used to help with backend simulation logic, frontend design, and general development support. All final decisions, integration, and project direction were made by the authors.
