import { ActionPanel, Action, List, showToast, Toast, getPreferenceValues } from "@raycast/api";
import { useEffect, useState } from "react";
import { exec } from "child_process";
import { promisify } from "util";

const execAsync = promisify(exec);

interface YabaiWindow {
  id: number;
  app: string;
  title: string;
  display: number;
  space: number;
  focused: boolean;
}

interface YabaiDisplay {
  id: number;
  index: number;
  frame: {
    w: number;
    h: number;
  };
  spaces: number[];
}

interface YabaiSpace {
  id: number;
  index: number;
  label: string;
  display: number;
  visible: boolean;
}

export default function YabaiWorkspaceManager() {
  const [windows, setWindows] = useState<YabaiWindow[]>([]);
  const [displays, setDisplays] = useState<YabaiDisplay[]>([]);
  const [spaces, setSpaces] = useState<YabaiSpace[]>([]);
  const [isLoading, setIsLoading] = useState(true);

  useEffect(() => {
    loadYabaiData();
  }, []);

  async function loadYabaiData() {
    try {
      setIsLoading(true);
      
      // Check if Yabai is running
      try {
        await execAsync("yabai -m query --displays");
      } catch (error) {
        await showToast({
          style: Toast.Style.Failure,
          title: "Yabai not running",
          message: "Please start Yabai first"
        });
        return;
      }

      // Load windows
      const { stdout: windowsOutput } = await execAsync("yabai -m query --windows");
      const windowsData = JSON.parse(windowsOutput);
      setWindows(windowsData);

      // Load displays
      const { stdout: displaysOutput } = await execAsync("yabai -m query --displays");
      const displaysData = JSON.parse(displaysOutput);
      setDisplays(displaysData);

      // Load spaces
      const { stdout: spacesOutput } = await execAsync("yabai -m query --spaces");
      const spacesData = JSON.parse(spacesOutput);
      setSpaces(spacesData);

    } catch (error) {
      await showToast({
        style: Toast.Style.Failure,
        title: "Error loading Yabai data",
        message: String(error)
      });
    } finally {
      setIsLoading(false);
    }
  }

  async function moveWindowToDisplay(windowId: number, displayIndex: number) {
    try {
      await execAsync(`yabai -m window --display ${displayIndex}`);
      await showToast({
        style: Toast.Style.Success,
        title: "Window moved",
        message: `Moved to display ${displayIndex}`
      });
      loadYabaiData();
    } catch (error) {
      await showToast({
        style: Toast.Style.Failure,
        title: "Failed to move window",
        message: String(error)
      });
    }
  }

  async function focusWindow(windowId: number) {
    try {
      await execAsync(`yabai -m window --focus ${windowId}`);
      await showToast({
        style: Toast.Style.Success,
        title: "Window focused"
      });
    } catch (error) {
      await showToast({
        style: Toast.Style.Failure,
        title: "Failed to focus window",
        message: String(error)
      });
    }
  }

  async function loadWorkspaceProfile(profile: string) {
    try {
      const yabaiDir = `${process.env.HOME}/Desktop/YABAI`;
      await execAsync(`cd "${yabaiDir}" && source workspace_profiles/${profile}_profile.sh`);
      await showToast({
        style: Toast.Style.Success,
        title: "Profile loaded",
        message: `${profile} profile activated`
      });
      loadYabaiData();
    } catch (error) {
      await showToast({
        style: Toast.Style.Failure,
        title: "Failed to load profile",
        message: String(error)
      });
    }
  }

  async function rotateLayout() {
    try {
      await execAsync("yabai -m space --rotate 90");
      await showToast({
        style: Toast.Style.Success,
        title: "Layout rotated"
      });
      loadYabaiData();
    } catch (error) {
      await showToast({
        style: Toast.Style.Failure,
        title: "Failed to rotate layout",
        message: String(error)
      });
    }
  }

  const groupedWindows = windows.reduce((acc, window) => {
    const key = `Display ${window.display}`;
    if (!acc[key]) acc[key] = [];
    acc[key].push(window);
    return acc;
  }, {} as Record<string, YabaiWindow[]>);

  return (
    <List isLoading={isLoading} searchBarPlaceholder="Search windows and actions...">
      <List.Section title="Quick Actions">
        <List.Item
          title="Load Work Profile"
          subtitle="Development & Productivity"
          icon="💼"
          actions={
            <ActionPanel>
              <Action title="Load Work Profile" onAction={() => loadWorkspaceProfile("work")} />
            </ActionPanel>
          }
        />
        <List.Item
          title="Load Personal Profile"
          subtitle="Entertainment & Social"
          icon="🏠"
          actions={
            <ActionPanel>
              <Action title="Load Personal Profile" onAction={() => loadWorkspaceProfile("personal")} />
            </ActionPanel>
          }
        />
        <List.Item
          title="Load AI Research Profile"
          subtitle="AI & ML Development"
          icon="🤖"
          actions={
            <ActionPanel>
              <Action title="Load AI Research Profile" onAction={() => loadWorkspaceProfile("ai_research")} />
            </ActionPanel>
          }
        />
        <List.Item
          title="Rotate Layout"
          subtitle="Rotate current space layout"
          icon="🔄"
          actions={
            <ActionPanel>
              <Action title="Rotate Layout" onAction={rotateLayout} />
            </ActionPanel>
          }
        />
        <List.Item
          title="Refresh Data"
          subtitle="Reload Yabai information"
          icon="🔄"
          actions={
            <ActionPanel>
              <Action title="Refresh Data" onAction={loadYabaiData} />
            </ActionPanel>
          }
        />
      </List.Section>

      {Object.entries(groupedWindows).map(([displayKey, displayWindows]) => (
        <List.Section key={displayKey} title={displayKey}>
          {displayWindows.map((window) => (
            <List.Item
              key={window.id}
              title={window.app}
              subtitle={`${window.title} (Space ${window.space})${window.focused ? " • Focused" : ""}`}
              icon={window.focused ? "🎯" : "🪟"}
              accessories={[
                { text: `Display ${window.display}` },
                { text: `Space ${window.space}` }
              ]}
              actions={
                <ActionPanel>
                  <Action title="Focus Window" onAction={() => focusWindow(window.id)} />
                  <Action title="Move to Display 1" onAction={() => moveWindowToDisplay(window.id, 1)} />
                  <Action title="Move to Display 2" onAction={() => moveWindowToDisplay(window.id, 2)} />
                  <Action title="Move to Display 3" onAction={() => moveWindowToDisplay(window.id, 3)} />
                  <Action title="Refresh Data" onAction={loadYabaiData} />
                </ActionPanel>
              }
            />
          ))}
        </List.Section>
      ))}

      <List.Section title="Displays">
        {displays.map((display) => (
          <List.Item
            key={display.id}
            title={`Display ${display.index}`}
            subtitle={`${display.frame.w}x${display.frame.h} • Spaces: ${display.spaces.join(", ")}`}
            icon="🖥️"
          />
        ))}
      </List.Section>

      <List.Section title="Spaces">
        {spaces.map((space) => (
          <List.Item
            key={space.id}
            title={`Space ${space.index}`}
            subtitle={`Display ${space.display}${space.visible ? " • Visible" : ""}`}
            icon={space.visible ? "👁️" : "👁️‍🗨️"}
          />
        ))}
      </List.Section>
    </List>
  );
} 