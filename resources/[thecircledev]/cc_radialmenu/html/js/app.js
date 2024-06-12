document.addEventListener('DOMContentLoaded', () => {
  const menuData = {
    "mainMenu": [
      {
        "name": "Normal",
        "action": "submenu",
        "submenuKey": "normalSubMenu"
      },
      {
        "name": "Interact",
        "action": "alert",
        "message": "Interactive action performed!"
      }
    ],
    "subMenus": {
      "normalSubMenu": [
        {
          "name": "Item 1",
          "action": "alert",
          "message": "Item 1 selected!"
        },
        {
          "name": "Item 2",
          "action": "submenu",
          "submenuKey": "level1SubMenu"
        },
        {
          "name": "Item 3",
          "action": "alert",
          "message": "Item 3 selected!"
        },
        {
          "name": "Item 4",
          "action": "alert",
          "message": "Item 4 selected!"
        },
        {
          "name": "Item 5",
          "action": "alert",
          "message": "Item 5 selected!"
        },
        {
          "name": "Item 6",
          "action": "alert",
          "message": "Item 6 selected!"
        },
        {
          "name": "Submenu Level 2",
          "action": "submenu",
          "submenuKey": "level2SubMenu"
        }
      ],
      "level2SubMenu": [
        {
          "name": "Item 2-1",
          "action": "alert",
          "message": "Item 2-1 selected!"
        },
        {
          "name": "Item 2-2",
          "action": "alert",
          "message": "Item 2-2 selected!"
        }
      ]
    }
  };

  initializeMenu(menuData);
});

const navigationStack = [];

function initializeMenu(data) {
  const mainMenu = document.getElementById('firstPage');
  const submenuContainer = document.getElementById('submenuContainer');
  const backButton = document.getElementById('backButton');

  data.mainMenu.forEach(item => {
    const hexItem = createHexItem(item.name, () => handleMenuItemClick(item, 'mainMenu'));
    mainMenu.appendChild(hexItem);
  });

  backButton.addEventListener('click', handleBackClick);

  function handleMenuItemClick(item, currentMenuLevel) {
    if (item.action === 'submenu') {
      navigationStack.push(currentMenuLevel);
      displaySubMenu(item.submenuKey);
    } else if (item.action === 'alert') {
      alert(item.message);
    }
  }

  function displaySubMenu(subMenuKey) {
    const submenuData = data.subMenus[subMenuKey];
    submenuContainer.innerHTML = ''; // Clear existing submenu items

    submenuData.forEach(subItem => {
      const hexItem = createHexItem(subItem.name, () => handleMenuItemClick(subItem, subMenuKey));
      submenuContainer.appendChild(hexItem);
    });

    mainMenu.classList.add('hidden');
    submenuContainer.classList.remove('hidden');
    backButton.classList.remove('hidden');
  }

  function handleBackClick() {
    const lastMenu = navigationStack.pop();
    if (lastMenu === 'mainMenu') {
      mainMenu.classList.remove('hidden');
      submenuContainer.classList.add('hidden');
    } else {
      displaySubMenu(lastMenu);
    }

    if (navigationStack.length === 0) {
      backButton.classList.add('hidden');
    }
  }

  function createHexItem(name, onClick) {
    const hexItem = document.createElement('div');
    hexItem.classList.add('hex-item','text-white','text-center','bg-gradient-to-b','from-black', 'to-black/[0.1]');
    hexItem.innerHTML = `<div class="hex-content">${name}</div>`;
    hexItem.addEventListener('click', onClick);
    return hexItem;
  }
}
