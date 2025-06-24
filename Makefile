dev:
    @echo "🚀 Starting Next.js dev server..."
    npm install && npm run dev

api:
    @echo "🐍 Starting FastAPI..."
    uvicorn app.main:app --reload --host 0.0.0.0 --port 8000

test:
    @echo "🧪 Running tests..."
    pytest

setup:
    @echo "📦 Installing Python and Node dependencies..."
    pip install -r requirements.txt
    npm install
