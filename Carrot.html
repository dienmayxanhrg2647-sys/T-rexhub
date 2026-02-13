<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>carrot: Blue Sky & Fixed Controls</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no">
    <style>
        body { margin: 0; overflow: hidden; background: #87CEEB; font-family: sans-serif; touch-action: none; user-select: none; }
        canvas { display: block; }
        #ui { position: fixed; top: 10px; left: 50%; transform: translateX(-50%); width: 90%; text-align: center; pointer-events: none; z-index: 10; }
        .bar-bg { width: 100%; height: 20px; background: rgba(0,0,0,0.5); border: 2px solid #fff; border-radius: 10px; overflow: hidden; margin-top: 5px; }
        #prog-fill { width: 0%; height: 100%; background: #e67e22; transition: width 0.3s; }
        .boss-mode-fill { background: #ff4757 !important; box-shadow: 0 0 10px red; }
        #info { position: fixed; top: 80px; left: 20px; color: #fff; font-weight: bold; text-shadow: 2px 2px #000; background: rgba(0,0,0,0.4); padding: 10px; border-radius: 8px; font-size: 14px; }
        
        /* FIX NÚT BẤM TO VÀ RÕ */
        .controls { position: fixed; bottom: 30px; left: 0; width: 100%; display: flex; justify-content: space-between; padding: 0 25px; box-sizing: border-box; pointer-events: none; }
        .btn-group { display: flex; gap: 15px; align-items: flex-end; pointer-events: auto; }
        .btn { 
            width: 75px; height: 75px; 
            background: rgba(255,255,255,0.4); 
            border: 4px solid #fff; 
            border-radius: 15px; 
            display: flex; align-items: center; justify-content: center; 
            font-weight: 900; color: #fff; font-size: 14px; 
            text-shadow: 1px 1px 2px #000;
            position: relative; overflow: hidden;
            box-shadow: 0 5px 15px rgba(0,0,0,0.2);
            active { transform: scale(0.9); background: rgba(255,255,255,0.6); }
        }
        .locked { background: rgba(0,0,0,0.5) !important; color: #7f8c8d !important; border-color: #555 !important; }
        #best-btn { background: #f1c40f; color: #000; text-shadow: none; }
        #clone-btn { background: #2c3e50; }
        #s-btn { background: #27ae60; width: 85px; height: 85px; font-size: 16px; } /* Nút bắn to hơn */
        #j-btn { background: #2980b9; width: 85px; height: 85px; font-size: 16px; } /* Nút nhảy to hơn */
        .cd-overlay { position: absolute; bottom: 0; left: 0; width: 100%; background: rgba(0,0,0,0.7); height: 0%; }
        #notice { position: fixed; top: 40%; left: 50%; transform: translate(-50%, -50%); color: #fff; font-size: 35px; font-weight: 900; text-shadow: 3px 3px #000; display: none; text-align: center; z-index: 100; }
    </style>
</head>
<body>
    <div id="notice">LEVEL CLEAR!</div>
    <div id="ui">
        <div style="color:white; text-shadow: 2px 2px #000; font-weight:bold;">NHIỆM VỤ: <span id="task-label">SĂN THỎ</span></div>
        <div class="bar-bg"><div id="prog-fill"></div></div>
    </div>
    <div id="info">MÀN: <span id="wins">1</span> | HP: <span id="player-hp">600</span></div>
    <canvas id="gameCanvas"></canvas>
    <div class="controls">
        <div class="btn-group">
            <div id="l-btn" class="btn">←</div>
            <div id="r-btn" class="btn">→</div>
        </div>
        <div class="btn-group">
            <div id="best-btn" class="btn locked">ULTI<div id="best-overlay" class="cd-overlay"></div></div>
            <div id="clone-btn" class="btn locked">TEAM<div id="clone-overlay" class="cd-overlay"></div></div>
            <div id="s-btn" class="btn">BẮN</div>
            <div id="j-btn" class="btn">NHẢY</div>
        </div>
    </div>

<script>
    const canvas = document.getElementById('gameCanvas');
    const ctx = canvas.getContext('2d');
    canvas.width = window.innerWidth; canvas.height = window.innerHeight;
    const groundY = canvas.height - 100;

    let winCount = 0, targetKills = 10, rabbitHpBase = 150, bossHpBase = 5000;
    let rabbitSpeedBase = 2.5, rabbitDmgBase = 5;
    let killCount = 0, camX = 0, spawnTimer = 0, gameState = "HUNTING";
    let currentBoss = null, explosions = [];
    let cloneCD = 0, maxCloneCD = 400, bestCD = 0, maxBestCD = 1000;

    const player = { x: 100, y: groundY-80, w: 55, h: 75, dx: 0, dy: 0, speed: 7.5, jForce: 20, grav: 1.1, ground: true, right: true, hp: 600, maxHp: 600 };
    let bullets = [], enemies = [], clones = [];
    const keys = { l: false, r: false };

    function drawHP(x, y, w, hp, maxHp, color) {
        ctx.fillStyle = "rgba(0,0,0,0.8)"; ctx.fillRect(x, y - 25, w, 8);
        ctx.fillStyle = color;
        ctx.fillRect(x, y - 25, Math.max(0, (hp / maxHp) * w), 8);
        ctx.strokeStyle = "white"; ctx.strokeRect(x, y - 25, w, 8);
    }

    function drawCarrot(x, y, w, h, hp, maxHp, color, type) {
        drawHP(x, y, w, hp, maxHp, type === 'suicide' ? "#000" : "#2ecc71");
        ctx.fillStyle = color; ctx.strokeStyle = "black"; ctx.lineWidth = 2;
        ctx.beginPath(); ctx.moveTo(x, y); ctx.lineTo(x + w, y); ctx.lineTo(x + w/2, y + h); ctx.closePath(); ctx.fill(); ctx.stroke();
        ctx.fillStyle = "black"; ctx.beginPath(); ctx.arc(x+w*0.35, y+h*0.3, 4, 0, Math.PI*2); ctx.arc(x+w*0.65, y+h*0.3, 4, 0, Math.PI*2); ctx.fill();
        ctx.fillStyle = type === 'suicide' ? "#000" : "#27ae60"; ctx.fillRect(x+w*0.3, y-12, w*0.4, 12); ctx.strokeRect(x+w*0.3, y-12, w*0.4, 12);
    }

    function drawRabbit(en) {
        const time = Date.now() / 150;
        const bounce = Math.abs(Math.sin(time)) * 8;
        ctx.save(); ctx.translate(en.x, en.y - bounce);
        ctx.fillStyle = "white"; ctx.strokeStyle = "black"; ctx.lineWidth = 2;
        ctx.beginPath(); ctx.ellipse(en.w*0.3, 0, en.w*0.1, en.h*0.4, 0, 0, Math.PI*2); ctx.fill(); ctx.stroke();
        ctx.beginPath(); ctx.ellipse(en.w*0.7, 0, en.w*0.1, en.h*0.4, 0, 0, Math.PI*2); ctx.fill(); ctx.stroke();
        ctx.beginPath(); ctx.ellipse(en.w/2, en.h*0.6, en.w/2, en.h*0.4, 0, 0, Math.PI*2); ctx.fill(); ctx.stroke();
        ctx.beginPath(); ctx.arc(en.w/2, en.h*0.3, en.w*0.3, 0, Math.PI*2); ctx.fill(); ctx.stroke();
        ctx.fillStyle = en.isBoss ? "red" : "black";
        ctx.beginPath(); ctx.arc(en.w*0.35, en.h*0.25, en.isBoss?6:3, 0, Math.PI*2); ctx.fill();
        ctx.beginPath(); ctx.arc(en.w*0.65, en.h*0.25, en.isBoss?6:3, 0, Math.PI*2); ctx.fill();
        ctx.restore();
        drawHP(en.x, en.y - bounce, en.w, en.hp, en.maxHp, "#ff4757");
    }

    const setup = (id, act) => {
        const b = document.getElementById(id);
        const start = (e) => {
            e.preventDefault();
            if(act==='j' && player.ground) { player.dy = -player.jForce; player.ground = false; }
            else if(act==='s') bullets.push({ x: player.x + (player.right?50:-10), y: player.y + 30, dx: player.right?22:-22, w:20, h:15 });
            else if(act==='c' && (winCount + 1) >= 2 && cloneCD <= 0) {
                for(let i=0; i<4; i++) clones.push({ x: player.x+Math.random()*80-40, y: groundY-55, w:40, h:55, hp:500, maxHp:500, speed:5, color:'#e67e22', type:'normal' });
                clones.push({ x: player.x, y: groundY-60, w:45, h:60, hp:400, maxHp:400, speed:9, color:'#2c3e50', type:'suicide' });
                cloneCD = maxCloneCD;
            } else if(act==='bc' && (winCount + 1) >= 3 && bestCD <= 0) {
                clones.push({ x: player.x, y: groundY-115, w:85, h:115, hp:8000, maxHp:8000, speed:4.5, color: 'gold', type:'normal' });
                bestCD = maxBestCD;
            } else keys[act]=true;
        };
        const end = (e) => { e.preventDefault(); if(act==='l'||act==='r') keys[act]=false; };
        b.addEventListener('touchstart', start); b.addEventListener('touchend', end);
        b.addEventListener('mousedown', start); b.addEventListener('mouseup', end);
    };
    setup('l-btn', 'l'); setup('r-btn', 'r'); setup('j-btn', 'j'); setup('s-btn', 's'); setup('clone-btn', 'c'); setup('best-btn', 'bc');

    function update() {
        if(gameState === "CLEAR") return;
        player.dy += player.grav; player.y += player.dy;
        if(player.y + player.h > groundY) { player.y = groundY - player.h; player.dy = 0; player.ground = true; }
        if(keys.l) { player.dx = -player.speed; player.right = false; } else if(keys.r) { player.dx = player.speed; player.right = true; } else player.dx = 0;
        player.x += player.dx;
        camX += (player.x - camX - canvas.width/2) * 0.1;

        if(cloneCD > 0) cloneCD--; if(bestCD > 0) bestCD--;
        document.getElementById('clone-overlay').style.height = (cloneCD/maxCloneCD*100) + "%";
        document.getElementById('best-overlay').style.height = (bestCD/maxBestCD*100) + "%";
        if ((winCount + 1) >= 2) document.getElementById('clone-btn').classList.remove('locked');
        if ((winCount + 1) >= 3) document.getElementById('best-btn').classList.remove('locked');

        const progFill = document.getElementById('prog-fill');
        if(gameState === "HUNTING") {
            progFill.classList.remove('boss-mode-fill');
            progFill.style.width = (killCount / targetKills * 100) + "%";
            document.getElementById('task-label').innerText = `SĂN THỎ (${killCount}/${targetKills})`;
            if(killCount < targetKills) {
                if(enemies.length < 12 && ++spawnTimer > 40) {
                    enemies.push({ x: player.x + (Math.random() > 0.5 ? 700 : -700), y: groundY-65, w: 50, h: 65, hp: rabbitHpBase, maxHp: rabbitHpBase, speed: rabbitSpeedBase, isBoss: false, dmg: rabbitDmgBase });
                    spawnTimer = 0;
                }
            } else {
                gameState = "BOSS";
                currentBoss = { x: player.x + 800, y: groundY-180, w: 180, h: 180, hp: bossHpBase, maxHp: bossHpBase, speed: rabbitSpeedBase * 0.8, isBoss: true, dmg: rabbitDmgBase * 3 };
                enemies.push(currentBoss);
            }
        } else if(gameState === "BOSS") {
            progFill.classList.add('boss-mode-fill');
            progFill.style.width = (currentBoss.hp / currentBoss.maxHp * 100) + "%";
            document.getElementById('task-label').innerText = "BOSS XUẤT HIỆN!";
        }

        for (let i = enemies.length - 1; i >= 0; i--) {
            let en = enemies[i];
            let target = player;
            let minDist = Math.abs(player.x - en.x);
            clones.forEach(c => { let d = Math.abs(c.x - en.x); if (d < minDist) { minDist = d; target = c; } });
            if (en.x < target.x) en.x += en.speed; else en.x -= en.speed;
            if(Math.abs(target.x - en.x) < en.w * 0.8) {
                target.hp -= en.dmg;
                if(target !== player) target.x += (en.x < target.x ? 2 : -2);
            }
            if(en.hp <= 0) { let isB = en.isBoss; enemies.splice(i, 1); if(isB) triggerWin(); else if(gameState === "HUNTING") killCount++; }
        }

        for (let ci = clones.length - 1; ci >= 0; ci--) {
            let c = clones[ci]; let nearEn = enemies[0];
            if(nearEn) {
                if (c.x < nearEn.x) c.x += c.speed; else c.x -= c.speed;
                if(c.type === 'suicide' && Math.abs(c.x - nearEn.x) < 45) c.hp = 0;
                else if(Math.abs(c.x - nearEn.x) < 60) nearEn.hp -= 20;
            }
            if (c.hp <= 0) {
                if(c.type === 'suicide') {
                    explosions.push({ x: c.x, y: c.y, r: 10, alpha: 1 });
                    enemies.forEach(en => { if(Math.abs(en.x - c.x) < 250) en.hp -= en.isBoss ? (en.maxHp * 0.3) : 2000; });
                }
                clones.splice(ci, 1);
            }
        }

        explosions.forEach((ex, i) => { ex.r += 15; ex.alpha -= 0.05; if(ex.alpha <= 0) explosions.splice(i, 1); });

        for (let bi = bullets.length - 1; bi >= 0; bi--) {
            let b = bullets[bi]; b.x += b.dx;
            for (let en of enemies) {
                if (b.x < en.x + en.w && b.x + b.w > en.x && b.y < en.y + en.h && b.y + b.h > en.y) {
                    en.hp -= 150; bullets.splice(bi, 1); break;
                }
            }
            if (bullets[bi] && Math.abs(b.x - player.x) > 1200) bullets.splice(bi, 1);
        }

        if(player.hp <= 0) location.reload();
        document.getElementById('player-hp').innerText = Math.ceil(player.hp);
        document.getElementById('wins').innerText = winCount + 1;
    }

    function triggerWin() {
        gameState = "CLEAR"; winCount++;
        targetKills *= 2; rabbitHpBase *= 2.1; bossHpBase *= 2.2;
        rabbitSpeedBase += 0.4; rabbitDmgBase *= 1.7;
        enemies = []; bullets = []; explosions = [];
        player.hp = Math.min(600, player.hp + 200);
        document.getElementById('notice').style.display = 'block';
        setTimeout(() => { document.getElementById('notice').style.display = 'none'; gameState = "HUNTING"; killCount = 0; }, 2500);
    }

    function draw() {
        ctx.clearRect(0,0, canvas.width, canvas.height);
        ctx.save(); ctx.translate(-camX, 0);
        let floorStart = Math.floor(camX / 500) * 500 - 500;
        for(let i=0; i<5; i++) {
            ctx.fillStyle = "#5d4037"; ctx.fillRect(floorStart + i*500, groundY, 501, 100);
            ctx.fillStyle = "#2ecc71"; ctx.fillRect(floorStart + i*500, groundY, 501, 10);
        }
        drawCarrot(player.x, player.y, player.w, player.h, player.hp, player.maxHp, "#e67e22", 'player');
        clones.forEach(c => drawCarrot(c.x, c.y, c.w, c.h, c.hp, c.maxHp, c.color, c.type));
        enemies.forEach(en => drawRabbit(en));
        explosions.forEach(ex => {
            ctx.beginPath(); ctx.arc(ex.x, ex.y, ex.r, 0, Math.PI*2);
            ctx.fillStyle = `rgba(255, 69, 0, ${ex.alpha})`; ctx.fill();
        });
        ctx.fillStyle = "yellow"; bullets.forEach(b => ctx.fillRect(b.x, b.y, b.w, b.h));
        ctx.restore(); update(); requestAnimationFrame(draw);
    }
    draw();
</script>
</body>
</html>
